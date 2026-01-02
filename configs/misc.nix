{ pkgs, ... }:
let
  # Dracula Color Palette
  # https://draculatheme.com/contribute
  dracula = {
    background = "#282a36";
    currentLine = "#44475a";
    selection = "#44475a";
    foreground = "#f8f8f2";
    comment = "#6272a4";
    cyan = "#8be9fd";
    green = "#50fa7b";
    orange = "#ffb86c";
    pink = "#ff79c6";
    purple = "#bd93f9";
    red = "#ff5555";
    yellow = "#f1fa8c";
    # Additional variants with transparency
    withAlpha = alpha: color: "${color}${alpha}";
  };
in
{
  extensions = with pkgs.vscode-marketplace; [ ];

  settings = {
    # Error lens docs: https://github.com/usernamehw/vscode-error-lens/blob/master/docs/docs.md#errorlensfontsize
    "errorLens.borderRadius" = "";
    "errorLens.codeLensEnabled" = false;
    "errorLens.codeLensOnClick" = "showProblemsView";
    # To match dracula theme (looks ugly otherwise)
    "errorLens.decorations" = {
      "errorMessage" = {
        "backgroundColor" = dracula.withAlpha "20" dracula.red;
        "color" = dracula.red;
      };
      "hintMessage" = {
        "backgroundColor" = dracula.withAlpha "20" dracula.comment;
        "color" = dracula.comment;
      };
      "infoMessage" = {
        "backgroundColor" = dracula.withAlpha "20" dracula.yellow;
        "color" = dracula.yellow;
      };
      "warningMessage" = {
        "backgroundColor" = dracula.withAlpha "20" dracula.cyan;
        "color" = dracula.cyan;
      };
    };
    "errorLens.enabledDiagnosticLevels" = [
      "error"
      # Low-key a bit distracting
      # "warning"
      # "info"
      # "hint"
    ];
    "errorLens.followCursor" = "allLines";
    "errorLens.fontFamily" = "FiraCode Nerd Font";
    "errorLens.fontSize" = "0.8em";
    "errorLens.messageBackgroundMode" = "message";
    "errorLens.messageEnabled" = true;
    "errorLens.padding" = "2px 1ch";
    # "indentRainbow.colors" = [
    #   "rgba(255,255,64,0.03)"
    #   "rgba(127,255,127,0.03)"
    #   "rgba(255,127,255,0.03)"
    #   "rgba(79,236,236,0.03)"
    # ];
    # "indentRainbow.errorColor" = "rgba(128,32,32,0.3)";
    # "indentRainbow.tabmixColor" = "rgba(128,32,96,0.3)";
    "powermode.combo.counterSize" = 1;
    "powermode.combo.location" = "editor";
    "powermode.combo.threshold" = 5;
    "powermode.explosions.gifMode" = "restart";
    "powermode.explosions.maxExplosions" = 3;
    "powermode.explosions.size" = 10;
    # https://code.visualstudio.com/docs/copilot/reference/copilot-settings
    "chat.commandCenter.enabled" = false;
    "github.copilot.enable" = {
      "*" = false;
      "comments" = false;
      "markdown" = false;
      "plaintext" = false;
      "scminput" = false;
    };
    "github.copilot.nextEditSuggestions.enabled" = false;
  };

}
