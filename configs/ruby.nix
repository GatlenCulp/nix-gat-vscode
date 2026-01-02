{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "[ruby]" = {
      "editor.defaultFormatter" = "Shopify.ruby-lsp";
      "editor.formatOnSave" = true;
      "editor.insertSpaces" = true;
      "editor.semanticHighlighting.enabled" = true;
      "editor.tabSize" = 2;
      "editor.wordSeparators" = ''`~@#$%^&*()-=+[{]}\|;:'",.<>/'';
    };
  };
}
