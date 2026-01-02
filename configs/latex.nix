{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "[latex]" = {
      "editor.defaultFormatter" = "James-Yu.latex-workshop";
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.wordWrap" = "on";
    };
    "[tex]" = {
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.wordWrap" = "on";
    };
    "latex-workshop.bibtex-format.sort.enabled" = true;
    "latex-workshop.formatting.latex" = "tex-fmt";
    "latex-workshop.intellisense.subsuperscript.enabled" = true;
    "latex-workshop.showContextMenu" = true;
    "latex-workshop.synctex.indicator" = "circle";
    "latex-workshop.view.autoFocus.enabled" = true;
    "latex-workshop.view.outline.sync.viewer" = true;
    "latex-workshop.view.pdf.color.dark.backgroundColor" = "#333333";
  };
}
