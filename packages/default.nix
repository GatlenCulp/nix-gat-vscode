{
  pkgs,
  flake,
  ...
}:
let
  inherit (flake) self;
  # Import VSCode extensions
  vscodeExtensions = import (self + /modules/home-manager/vscode/vscode-extensions.nix) {
    inherit pkgs;
  };

  # Build a standalone VSCode package with extensions
  mkVSCode =
    extensions:
    (pkgs.vscode-with-extensions.override {
      vscodeExtensions = extensions;
    }).overrideAttrs
      (oldAttrs: {
        # Ensure meta.mainProgram is set for `nix run`
        meta = (oldAttrs.meta or { }) // {
          mainProgram = "code";
        };
      });

  vscodePackage = mkVSCode vscodeExtensions;
in
{
  packages = {
    # Default package: VSCode with all configured extensions
    default = vscodePackage;

    # Alias for clarity
    vscode = vscodePackage;
  };

  # Explicit apps output for `nix run`
  apps = {
    default = {
      type = "app";
      program = "${vscodePackage}/bin/code";
    };
    vscode = {
      type = "app";
      program = "${vscodePackage}/bin/code";
    };
  };
}
