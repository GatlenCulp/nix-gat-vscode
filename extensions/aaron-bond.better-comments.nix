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
  extensions = with pkgs.vscode-marketplace; [
    aaron-bond.better-comments
  ];

  settings = {
    # Note: Uses better-comments next for more features
    "better-comments.highlightPlainText" = false;
    "better-comments.tags" = [
      ### TAGS
      {
        bold = true;
        color = dracula.red;
        italic = true;
        tag = "!!";
      }
      {
        bold = true;
        color = dracula.red;
        italic = true;
        tag = "warning";
      }
      {
        bold = true;
        color = dracula.pink;
        italic = true;
        tag = "??";
      }
      {
        bold = true;
        color = dracula.pink;
        italic = true;
        tag = "question";
      }
      {
        bold = true;
        color = dracula.cyan;
        italic = true;
        tag = "info";
      }
      {
        color = dracula.comment;
        italic = true;
        strikethrough = true;
        tag = "//";
      }
      {
        bold = true;
        color = dracula.orange;
        italic = true;
        tag = "fixme";
      }
      {
        bold = true;
        color = dracula.foreground;
        italic = true;
        tag = "━";
      }
      {
        bold = true;
        color = dracula.foreground;
        italic = true;
        tag = "─";
      }
      {
        color = dracula.foreground;
        italic = true;
        tag = "##";
        underline = true;
      }
      ### PYTHON (Python Interactive Specifically)
      # Would provide backgroud but does not cover full line :/
      {
        bold = true;
        color = dracula.green;
        italic = true;
        tag = "%%";
      }
      {
        bold = true;
        color = dracula.green;
        italic = true;
        tag = ">>";
      }
    ];
  };
}
