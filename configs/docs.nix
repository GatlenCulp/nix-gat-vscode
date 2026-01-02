{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "[markdown]" = {
      "editor.defaultFormatter" = "prettier.prettier-vscode";
      "editor.snippetSuggestions" = "inline";
      "editor.suggest.showSnippets" = true;
    };
  };
}
