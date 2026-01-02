{ self, pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "[nix]" = {
      "editor.defaultFormatter" = "jnoortheen.nix-ide";
      "editor.formatOnSave" = true;
      "editor.insertSpaces" = true;
      "editor.tabSize" = 2;
    };
    "nix.enableLanguageServer" = true;
    # Fallback formatter
    # "nix.formatterPath" = "nixfmt"; # I think messes with things? not sure.
    "nix.serverPath" = "nixd";
    "nix.serverSettings" = {
      "nixd" = {
        "formatting" = {
          "command" = [ "/run/current-system/sw/bin/nixfmt" ];
        };
        "options" = {
          "home-manager" = {
            "expr" = ''(builtins.getFlake "${self}").darwinConfigurations.gatty.options'';
          };
          "nix-config" = {
            "expr" = ''(builtins.getFlake "${self}").darwinConfigurations.gatty.options'';
          };
          "nixos" = {
            "expr" = ''(builtins.getFlake "${self}").darwinConfigurations.gatty.options'';
          };
        };
      };
    };
  };
}
