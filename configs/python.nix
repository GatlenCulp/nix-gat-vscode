{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "[python]" = {
      "editor.codeActionsOnSave" = {
        "source.fixAll" = "explicit";
        "source.organizeImports" = "explicit";
      };
      "editor.defaultFormatter" = "charliermarsh.ruff";
      # Worth disabling for repos that are not my own
      "editor.formatOnSave" = true;
    };
    "autoDocstring.docstringFormat" = "google-notypes";
    "autoDocstring.startOnNewLine" = true;
    "python.REPL.sendToNativeREPL" = true;
    "python.testing.pytestEnabled" = true;
    "ruff.codeAction.fixViolation" = {
      enable = false;
    };
    "ruff.configuration" = "~/.config/ruff/ruff.toml";
  };
}
