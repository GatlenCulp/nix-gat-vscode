{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "[css]"."editor.defaultFormatter" = "prettier.prettier-vscode";
    "[html]"."editor.defaultFormatter" = "prettier.prettier-vscode";
    "[javascript]"."editor.defaultFormatter" = "biomejs.biome";
    "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
    "[typescript]"."editor.defaultFormatter" = "biomejs.biome";
  };
}
