{
  pkgs,
  flake,
  ...
}:
let
  inherit (flake) self;
  # Import VSCode extensions the same way the Home Manager module does:
  # modular extensions from /extensions plus the legacy flat list.
  extensionModules = import (self + /extensions) {
    inherit pkgs;
    inherit (pkgs) lib;
  };
  legacyExtensions = import (self + /modules/home-manager/vscode/extensions.nix) {
    inherit pkgs;
  };
  vscodeExtensions = extensionModules.extensions ++ legacyExtensions;

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
