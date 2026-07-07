{
  pkgs,
  self,
  config,
  lib,
  ...
}:
let
  # Import modular extensions
  extensionModules = import ../../../extensions { inherit pkgs lib; };

  # DECLARATIVE merged settings: modular extension settings combined with the
  # legacy settings assembly. This is the *base* (Nix-owned) configuration.
  # Kept fully declarative so it can be diffed/reviewed in the repo.
  mergedSettings = extensionModules.settings // (import ./settings.nix { inherit self config; });

  # Absolute macOS paths for VS Code's User config directory.
  vscodeUserDir = "${config.home.homeDirectory}/Library/Application Support/Code/User";
in
{
  programs.vscode = {
    enable = true;
    # enableMcpIntegration = true; # Error?
    mutableExtensionsDir = true;
    profiles.default = {
      # Combine modular extensions with legacy extensions.
      # EXTENSIONS REMAIN FULLY DECLARATIVE (unchanged behavior).
      extensions = extensionModules.extensions ++ (import ./extensions.nix { inherit pkgs; });

      # NOTE: `userSettings` is intentionally NOT set here anymore. The
      # base + overlay merge below now owns `settings.json`, making it
      # live-editable while `mergedSettings` stays an enforced base.
      # To revert to the old fully-declarative behavior, import
      # ./settings.legacy.nix (see that file's header).

      # keybindings = [
      #   {
      #     key = "cmd+l";
      #     command = "claude-vscode.insertAtMention";
      #     when = "editorTextFocus";
      #   }
      # ];
    };
  };

  # BASE (Nix-owned, read-only): the full declarative settings, serialized to
  # JSON and linked into place from the Nix store. Never edited by hand.
  home.file."Library/Application Support/Code/User/settings.base.json".text =
    builtins.toJSON mergedSettings;

  # OVERLAY (live, editable): an out-of-store symlink to a plain JSON file in
  # the repo. Hand-edit this file to add/override settings; its keys win over
  # the base during the merge below.
  home.file."Library/Application Support/Code/User/settings.overrides.json".source =
    config.lib.file.mkOutOfStoreSymlink "${self}/configs/vscode-settings.overrides.json";

  # MERGE on activation: deep-merge base ⊕ overrides (overrides win) into a
  # writable `settings.json` that VS Code reads. Runs after home-manager has
  # linked the base/overlay files (linkGeneration), so both inputs exist.
  #
  # `jq -s '.[0] * .[1]'` performs a recursive object merge where the second
  # document (overrides) takes precedence over the first (base).
  home.activation.vscodeMergeSettings =
    lib.hm.dag.entryAfter
      [
        "writeBoundary"
        "linkGeneration"
      ]
      ''
        vscodeUserDir=${lib.escapeShellArg vscodeUserDir}
        base="$vscodeUserDir/settings.base.json"
        overrides="$vscodeUserDir/settings.overrides.json"
        settings="$vscodeUserDir/settings.json"

        if [ ! -e "$base" ]; then
          echo "vscodeMergeSettings: base file '$base' missing; skipping merge" >&2
        elif [ -e "$overrides" ]; then
          run ${pkgs.jq}/bin/jq -s '.[0] * .[1]' "$base" "$overrides" > "$settings"
        else
          # Overlay file missing: fall back to the base verbatim.
          echo "vscodeMergeSettings: overrides file '$overrides' missing; using base only" >&2
          run ${pkgs.jq}/bin/jq '.' "$base" > "$settings"
        fi
      '';
}
