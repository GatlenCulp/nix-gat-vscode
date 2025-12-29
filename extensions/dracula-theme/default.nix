{ pkgs, ... }:
{
  # Extension from marketplace
  extensions = with pkgs.vscode-marketplace; [
    dracula-theme.theme-dracula
    pkief.material-icon-theme
    pkief.material-product-icons
  ];

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

  # Theme settings
  settings = {
    "material-icon-theme.activeIconPack" = "react";
    "material-icon-theme.files.color" = "#90a4ae";
    "material-icon-theme.hidesExplorerArrows" = true;
    "material-icon-theme.opacity" = 1;
    "workbench.colorCustomizations" = {
      "titleBar.activeBackground" = "#692E33";
    };
    "workbench.colorTheme" = "Dracula Theme";
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.productIconTheme" = "material-product-icons";
  };
}
