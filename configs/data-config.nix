{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    # YAML Configs
    "[dockercompose]" = {
      "editor.defaultFormatter" = "redhat.vscode-yaml";
    };
    "[github-actions-workflow]"."editor.defaultFormatter" = "redhat.vscode-yaml";
    # JSON Configs
    "[json][jsonc][jsonl]" = {
      "editor.defaultFormatter" = "biomejs.biome";
      "editor.tabSize" = 2;
      "editor.wordWrap" = "on";
    };
    "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
    "json.format.enable" = true;
    "json.schemaDownload.enable" = true;
    "json.schemas" = [
      {
        "fileMatch" = [ ".cursor/hooks.json" ];
        "url" = "https://unpkg.com/cursor-hooks/schema/hooks.schema.json";
      }
    ];
    "json.validate.enable" = true;
  };
}
