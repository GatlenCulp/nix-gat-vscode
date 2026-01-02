{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "[shellscript]"."editor.defaultFormatter" = "mads-hartmann.bash-ide-vscode";
    # OSX Settings
    "terminal.external.osxExec" = "Ghostty.app";
    "terminal.integrated.cursorBlinking" = true;
    "terminal.integrated.cursorStyle" = "line";
    "terminal.integrated.enableImages" = true;
    "terminal.integrated.hideOnStartup" = "whenEmpty";
    "terminal.integrated.lineHeight" = 1.05;
    "terminal.integrated.rightClickBehavior" = "default";
    "terminal.integrated.shellIntegration.enabled" = true;
    "terminal.integrated.smoothScrolling" = true;
    "terminal.integrated.splitCwd" = "workspaceRoot";
    "terminal.integrated.stickyScroll.enabled" = true;
    "terminal.integrated.suggest.enabled" = true;
    "terminal.integrated.tabs.enabled" = true;
    "terminal.integrated.tabs.location" = "left";
    "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
    "terminal.integrated.fontSize" = 10;
    # PROFILE SETTINGS
    "terminal.integrated.defaultProfile.osx" = "Gatlen-nu";
    "terminal.integrated.profiles.osx" = {
      "Gatlen-zsh" = {
        "args" = [ "-l" ];
        "color" = "terminal.ansiBlue";
        "env" = {
          "value" = "\${workspaceFolder}/secrets/.env";
        };
        "icon" = "robot";
        "overrideName" = true;
        "path" = "zsh";
      };
      "Gatlen-nu" = {
        "args" = [ "-l" ];
        "color" = "terminal.ansiGreen";
        "env" = {
          "value" = "\${workspaceFolder}/secrets/.env";
        };
        "icon" = "robot";
        "overrideName" = true;
        "path" = "nu";
      };
    };
  };
}
