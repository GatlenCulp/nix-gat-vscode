# LEGACY: original fully-declarative `userSettings` assembly.
#
# This file is intentionally UNIMPORTED. It preserves the pre base+overlay
# behavior where the merged declarative settings were written straight to
# VS Code's `settings.json` (as a read-only Nix-store symlink), i.e. NOT
# live-editable.
#
# To revert to the old behavior:
#   1. In ./default.nix, remove the `home.file.".../settings.base.json"`,
#      `home.file.".../settings.overrides.json"`, and
#      `home.activation.vscodeMergeSettings` blocks.
#   2. Add this file to the home-manager imports (or inline the
#      `programs.vscode.profiles.default.userSettings` line below back into
#      ./default.nix).
#
# The `extensions` assembly is unaffected either way; only the settings file
# delivery mechanism changes.
{
  pkgs,
  self,
  config,
  lib,
  ...
}:
let
  # Import modular extensions (same source as ./default.nix).
  extensionModules = import ../../../extensions { inherit pkgs lib; };
in
{
  programs.vscode.profiles.default.userSettings =
    extensionModules.settings // (import ./settings.nix { inherit self config; });
}
