# Hermetic evaluation test for the VS Code base + overlay settings mechanism.
#
# Evaluates modules/home-manager/vscode/default.nix with fully mocked
# pkgs / self / config / lib (no network, no nixpkgs, no home-manager), then
# asserts the base+overlay wiring:
#
#   1. The `settings.overrides.json` home.file entry is an out-of-store symlink
#      pointing at configs/vscode-settings.overrides.json.
#   2. The `settings.base.json` home.file entry has non-empty JSON `text`.
#   3. `programs.vscode.profiles.default.extensions` is still defined (a list),
#      i.e. extensions remain declarative and untouched.
#
# Run with:  nix-instantiate --eval --strict tests/vscode-overlay.nix
# (or via tests/run-vscode.sh). Any failed assertion aborts evaluation.
let
  # --- Mocks -----------------------------------------------------------------

  self = "/mock/flake/root";

  # A sentinel returned by our mocked mkOutOfStoreSymlink so the test can
  # inspect the target path the module asked to symlink.
  config = {
    home.homeDirectory = "/mock/home";
    lib.file.mkOutOfStoreSymlink = target: {
      __outOfStoreSymlink = target;
    };
  };

  lib = {
    # We never execute the activation script here; a trivial string-preserving
    # stub is enough for evaluation.
    escapeShellArg = s: "'" + s + "'";
    hm.dag.entryAfter = after: data: { inherit after data; };
  };

  # pkgs.vscode-marketplace must not be *forced* by this test: extension list
  # elements stay as thunks (we only assert the list spine). If evaluation ever
  # forces it, that is a real regression and this throw makes it obvious.
  pkgs = {
    jq = "/mock/jq";
    vscode-marketplace = throw "tests/vscode-overlay.nix: pkgs.vscode-marketplace must not be forced (extensions are asserted lazily)";
  };

  # --- Module under test -----------------------------------------------------

  cfg = import ../modules/home-manager/vscode/default.nix {
    inherit
      pkgs
      self
      config
      lib
      ;
  };

  homeFiles = cfg.home.file;
  profile = cfg.programs.vscode.profiles.default;

  overridesEntry = homeFiles."Library/Application Support/Code/User/settings.overrides.json";
  baseEntry = homeFiles."Library/Application Support/Code/User/settings.base.json";

  # --- Assertions ------------------------------------------------------------

  overridesIsOutOfStoreSymlink =
    (overridesEntry ? source)
    && (overridesEntry.source ? __outOfStoreSymlink)
    && (
      let
        target = overridesEntry.source.__outOfStoreSymlink;
      in
      builtins.isString target
      && (
        let
          suffix = "/configs/vscode-settings.overrides.json";
          sl = builtins.stringLength suffix;
          tl = builtins.stringLength target;
        in
        tl >= sl && builtins.substring (tl - sl) sl target == suffix
      )
    );

  baseTextIsNonEmpty =
    (baseEntry ? text) && builtins.isString baseEntry.text && builtins.stringLength baseEntry.text > 0;

  extensionsStillSet = (profile ? extensions) && builtins.isList profile.extensions;

  checks = {
    inherit overridesIsOutOfStoreSymlink baseTextIsNonEmpty extensionsStillSet;
  };

  failures = builtins.filter (name: !checks.${name}) (builtins.attrNames checks);
in
# Abort with the list of failing checks if any assertion is false.
assert failures == [ ] || throw "vscode-overlay test failures: ${builtins.toString failures}";
{
  inherit checks;
  ok = true;
}
