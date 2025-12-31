<p align="center" style="color:grey">

<!-- ![image](https://github.com/niksingh710/nvix/assets/60490474/89503d51-ca86-4933-872f-3f60c32202a9) -->

Note: Duplicated from nvix repository

<div align="center">
<table>
<tbody>
<td align="center">
<img width="2000" height="0"><br>

# Gat-VSCode (Nix)

<!-- Nvix is a **modular**, **powerful**, and **reproducible** Neovim configuration framework powered by [Nixvim](https://github.com/nix-community/nixvim). It leverages the Nix ecosystem to provide flexible, reliable, and highly customizable Neovim environments—whether you need a lightweight config for quick edits or a comprehensive setup for full development workflows. -->

## Features

<!-- - **Modular by Design:** Each feature and plugin is its own module. Mix, match, or extend as you need.
- **Multiple Configurations:**
  - **Bare:** Minimal setup for fast, distraction-free editing and server use.
  - **Core:** Daily-driver configuration with LSP and language support.
  - **Full:** Comprehensive environment including advanced plugins (LaTeX, etc.).
- **Easy Customization:** Import only what you want, or override settings in `config.nvix`.
- **Flake Native:** Built for the modern Nix ecosystem. -->

Note: Will have to use the nixpkgs overlay available in this flake for it to work `flake.overlays.default`. Which is basically just `nix-vscode-extensions.overlays.default`

## Quickstart

Try VSCode with this configuration instantly (no install required):

```sh
# Run directly from GitHub
NIXPKGS_ALLOW_UNFREE=1 nix run "github:GatlenCulp/gat-vscode" --impure

# Or from a local clone
NIXPKGS_ALLOW_UNFREE=1 nix run . --impure
```

> **Note:** The `NIXPKGS_ALLOW_UNFREE=1` and `--impure` flags are required because some VSCode extensions have unfree licenses.

## Installation

### Prerequisites

- [Nix Package Manager](https://nixos.org/download.html) (multi-user recommended)
- Flakes enabled (`experimental-features = nix-command flakes`)
- [Home Manager](https://nix-community.github.io/home-manager/) configured

### Add as a flake input

```nix
# In your flake.nix
inputs.gat-vscode.url = "github:GatlenCulp/gat-vscode";
```

### Use as a Home Manager Module (Recommended)

Import the Home Manager module in your configuration:

```nix
# In your home-manager configuration
{
  imports = [
    inputs.gat-vscode.homeManagerModules.vscode
  ];
}
```

This will automatically enable VSCode with all configured extensions and settings.

### Or Use as a Package

If you prefer to install VSCode as a package without the full configuration:

```nix
# For NixOS
environment.systemPackages = [
  inputs.gat-vscode.packages.${pkgs.system}.default
];

# For Home Manager
home.packages = [
  inputs.gat-vscode.packages.${pkgs.system}.default
];
```

### Customization

Since this is a Home Manager module, you can override settings:

```nix
{
  imports = [
    inputs.gat-vscode.homeManagerModules.vscode
  ];

  # Override or extend VSCode settings
  programs.vscode.userSettings = {
    "editor.fontSize" = 14;
    "workbench.colorTheme" = "My Custom Theme";
  };

  # Add additional extensions
  programs.vscode.profiles.default.extensions = with pkgs.vscode-marketplace; [
    # Your additional extensions here
  ];
}
```

<!-- TODO: AI, replace everything with vscode -->

<!-- ## Using Plugins and Modules

Every plugin or feature in Nvix is a module, exposed under `nvixPlugins`.
For essential utilities, include the `common` module.

**Example: Importing modules in Nixvim:**
```nix
# Add to your flake inputs:
nvix.url = "github:niksingh710/nvix";

# In your Nixvim config:
modules = [
  inputs.nvix.nvixPlugins.common
  inputs.nvix.nvixPlugins.lualine
];
```

**Module Path Reference:**
- `plugins/filename.nix` → `inputs.nvix.nvixPlugins.filename`
- `plugins/somedir/default.nix` → `inputs.nvix.nvixPlugins.somedir` -->

## Configuration Types Overview

| Type        | Description                                                            | Includes           |
| ----------- | ---------------------------------------------------------------------- | ------------------ |
| `bare`    | Fast, minimal setup—ideal for servers or quick edits                  | Just the basics    |
| `default` | Core configuration with sensible defaults, LSP, and language support   | `bare` + extras  |
| `full`    | All-in-one, feature-rich setup including advanced plugins (e.g. LaTeX) | `default` + more |

## Previews

<!-- 
| ![1](https://github.com/user-attachments/assets/166946eb-716b-44b4-81c6-845ca6dfb411) | ![2](https://github.com/user-attachments/assets/bb1d6130-89f4-4fe5-92b1-1b7636cdacad) |
|---|---|
| ![3](https://github.com/user-attachments/assets/9ff23b31-eb85-40f2-b75b-5a09bac396e2) | ![4](https://github.com/user-attachments/assets/5766fb4f-3553-4008-ba0b-1fc5fa8a6dbe) |
| ![5](https://github.com/user-attachments/assets/3211a1e2-92f3-4dff-9b5c-8d4476f12a04) | ![6](https://github.com/user-attachments/assets/099cd474-b102-4b72-8ad9-f8f92f43dabd) |

**Fuzzy Finder:**
Nvix uses `Snacks.picker` (instead of Telescope) for an optimized fuzzy finding experience.

![picker](https://github.com/niksingh710/nvix/assets/60490474/52f91e06-5161-4217-8f84-5a6d390295a5) -->

## FAQs

<!-- 
**What is Nvix for?**
Nvix started as a Nix learning experiment and evolved into a robust, composable Neovim configuration framework.

**Why three configurations?**
- `bare`: Minimal, distraction-free
- `core`: Daily usage with LSP and language support
- `full`: Advanced workflows such as LaTeX

**Can I use just one module?**
Absolutely. Nvix is designed so you can import only what you need.

**Are contributions welcome?**
Yes! Docs, configs, plugins, suggestions—all are valued. Open a PR or issue.

**Why only some options in `config.nvix`?**
[Nixvim](https://github.com/nix-community/nixvim) already exposes most customization options. Nvix adds curated, ready-to-use modules. -->

### Contributing

<!-- 
> Just keep it simple, stupid! -> `kiss` design principle

You’re welcome to contribute in any way:
- Improve docs or fix typos
- Suggest features or plugin support
- Enhance language/LSP integration

**Important:**
This repository has undergone major revisions in the past, which has resulted in a larger history and increased cloning size.
To minimize download time and space, please use a single branch clone:

```sh
git clone --single-branch --branch master https://github.com/niksingh710/nvix.git

# ssh
git clone --single-branch --branch master git@github.com:niksingh710/nvix.git
```

Please open an issue or PR with your ideas or improvements! -->

### License

This project is licensed under the [MIT License](./LICENSE).
