# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Nix flake repository that provides modular VSCode and Neovim configurations. Originally forked from [nvix](https://github.com/niksingh710/nvix), this repo is being adapted to support both VSCode (via nix-vscode-extensions) and Neovim (via Nixvim) in a declarative, reproducible way.

**Key Technologies:**
- Nix Flakes for reproducible builds
- flake-parts for modular flake organization
- nix-vscode-extensions for VSCode marketplace integration
- Nixvim for Neovim configuration (legacy from nvix)
- Home Manager compatible

## Building and Testing

### Build Commands

Build specific package variants:
```bash
# Build core variant (default)
nix build .#core

# Build bare variant (minimal)
nix build .#bare

# Build all variants at once
nix build .#bare .#core
```

### Testing Variants

Run without installing:
```bash
nix run "github:GatlenCulp/gat-vscode#<type>"
# where <type> is: bare | default | full
```

### Development

Enter development shell:
```bash
nix develop
```

The devshell includes: `just`, `nil`, `nix-output-monitor`, `nixfmt-rfc-style`

Format all Nix files:
```bash
nixfmt .
```

## Architecture

### Flake Structure

The flake uses **flake-parts** for modular organization:

- `flake.nix` - Entry point, defines inputs and imports module directories
- `modules/flake/` - Core flake configuration and package definitions
  - `default.nix` - Configures overlays and imports packages
  - `devshell.nix` - Development environment with pre-commit hooks
- `packages/default.nix` - Defines the three package variants (bare, core, full)
- `overlays/default.nix` - Provides stable nixpkgs overlay
- `plugins/` - Modular Nixvim plugin configurations (legacy, being refactored)
- `vscode/` - VSCode configuration (new, actively developed)
  - `default.nix` - Main VSCode program configuration
  - `vscode-extensions.nix` - Extension declarations organized by category
  - `vscode-settings.nix` - Settings organized by profiles

### VSCode Configuration

The VSCode config uses a **profile-based architecture**:

**Extensions** (`vscode-extensions.nix`):
- Organized into nested attribute sets by category: `general`, `tools`, `langs`, `data`, `misc`
- Each category has subcategories (e.g., `langs.python`, `langs.nix`, `data.ds-ml`)
- Extensions are sourced from `pkgs.vscode-marketplace`
- A `selected` list controls which profiles are included in the final build
- Uses `flattenProfiles` to convert nested structure into a flat list

**Settings** (`vscode-settings.nix`):
- Organized into profile modules (themes, general, fonts, shell, git, python, nix, etc.)
- Each profile is a separate attribute set with related settings
- Uses Dracula color palette defined at the top for theming
- `selected` list determines which profiles are merged into final config
- Final settings are merged with `builtins.foldl'`

**Adding Extensions or Settings:**
1. Add extension to appropriate category in `vscode-extensions.nix`
2. If needed, add settings profile to `vscode-settings.nix`
3. Include profile in `selected` list of respective file

### Plugin/Module System

The repository uses a **modular import pattern**:

Each plugin directory (e.g., `plugins/lsp/`, `plugins/lang/`) has a `default.nix` that:
1. Contains the main configuration
2. Automatically imports all `.nix` files in that directory (except `default.nix` and `.md` files)
3. Uses this pattern:
```nix
imports = with builtins; with lib;
  map (fn: ./${fn}) (
    filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}"))
    (attrNames (readDir ./.))
  );
```

This allows splitting related configurations across multiple files while keeping a single import point.

### Package Variants

Three configuration tiers defined in `packages/default.nix`:

1. **bare** - Minimal functionality (common, buffer, ux, snacks)
2. **core** (default) - Bare + LSP, Git, UI plugins, AI support
3. **full** - Core + advanced features (LaTeX support)

Each variant is built by passing a list of modules to `mkNixvim`.

### Key Custom Configuration

**Icons & UI**: The `nvix` namespace in module configs provides shared settings:
- `config.nvix.icons` - Diagnostic and UI icons
- `config.nvix.border` - Border style for floating windows
- `config.nvix.leader` - Leader key (space)
- `config.nvix.mkKey` - Helper for creating keymaps

**SSH Clipboard**: The common module detects SSH sessions (`SSH_TTY` env var) and automatically configures OSC 52 clipboard integration for remote editing.

## Important Patterns

### When Adding VSCode Settings

Settings reference `${self}` for the flake root path (useful for absolute paths to config files). The `config` parameter provides access to Home Manager config (e.g., `${config.home.homeDirectory}`).

Example:
```nix
"nix.serverSettings" = {
  "nixd" = {
    "options" = {
      "home-manager" = {
        "expr" = ''(builtins.getFlake "${self}").darwinConfigurations.gatty.options'';
      };
    };
  };
};
```

### When Adding Nixvim Plugins

Follow the modular pattern:
1. Create new file in appropriate `plugins/` subdirectory
2. It will be auto-imported by the parent `default.nix`
3. Use `config.nvix.*` for shared settings
4. Include in appropriate variant list in `packages/default.nix`

### Nix Formatting

This repository uses `nixfmt-rfc-style` (RFC 166 style). A pre-commit hook enforces this formatting. Always format changes before committing.

## CI/CD

GitHub Actions workflow (`.github/workflows/ci.yaml`) builds `bare` and `core` variants on push/PR to master. Only Linux builds are tested.

## Transition Notes

This repository is in transition from pure Nixvim (nvix) to a hybrid VSCode + Neovim configuration:

- **Active development**: VSCode configuration in `vscode/`
- **Legacy/maintenance mode**: Nixvim plugins in `plugins/`
- **Git status shows**: Many plugin files deleted, new `vscode/` directory added
- The `packages/default.nix` still references Nixvim plugins but may be refactored

When making changes, be aware that:
- The `plugins/` directory still uses the old Nixvim structure
- New work is focused on VSCode configuration
- References to "nvix" in code are from the original Nixvim-focused repository
