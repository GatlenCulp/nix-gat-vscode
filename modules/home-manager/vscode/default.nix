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
in
{
  programs.vscode = {
    enable = true;
    # enableMcpIntegration = true; # Error?
    mutableExtensionsDir = true;
    profiles.default = {
      # Combine modular extensions with legacy extensions
      extensions = extensionModules.extensions ++ (import ./extensions.nix { inherit pkgs; });
      # Combine modular settings with legacy settings
      userSettings = extensionModules.settings // (import ./settings.nix { inherit self config; });
      keybindings = [
        {
          key = "cmd+l";
          command = "claude-vscode.insertAtMention";
          when = "editorTextFocus";
        }
      ];
    };
  };
}
