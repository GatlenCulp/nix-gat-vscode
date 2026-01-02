{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "[racket]" = {
      "editor.defaultFormatter" = "evzen-wybitul.magic-racket";
    };
  };
}
