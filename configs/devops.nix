{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    # "remote.SSH.showLoginTerminal" = true; # true for debugging
    # "remote.SSH.localServerDownload" = "always"; # issues in special cases
    "remote.SSH.defaultExtensions" = [
      "ms-python.vscode-pylance"
      "ms-python.debugpy"
      "charliermarsh.ruff"
      "njpwerner.autodocstring"
      "rodolphebarbanneau.python-docstring-highlighter"
      "kevinrose.vsc-python-indent"
      "ms-toolsai.jupyter"
      "ms-toolsai.jupyter-renderers"
      "mechatroner.rainbow-csv"
      "sbsnippets.pytorch-snippets"
      "mads-hartmann.bash-ide-vscode"
      "timonwong.shellcheck"
      "foxundermoon.shell-format"
      "mathematic.vscode-pdf"
      "vitaliymaz.vscode-svg-previewer"
      "ctcuff.font-preview"
      "james-yu.latex-workshop"
      "shd101wyy.markdown-preview-enhanced"
      "prettier.prettier-vscode"
      "mrmlnc.vscode-attrs-sorter"
      "richie5um2.vscode-sort-json"
      "2gua.rainbow-brackets"
      "aaron-bond.better-comments"
      "alefragnani.project-manager"
      "peterschmalfeldt.explorer-exclude"
      "christian-kohler.path-intellisense"
      "kisstkondoros.vscode-gutter-preview"
      "eamodio.gitlens"
      "humao.rest-client"
      "ms-vscode.makefile-tools"
      "task.vscode-task"
      "tamasfe.even-better-toml"
      "dotenv.dotenv-vscode"
      "redhat.vscode-yaml"
      "redhat.vscode-xml"
      "ibm.output-colorizer"
      "usernamehw.errorlens"
      "spmeesseman.vscode-taskexplorer"
    ];
    "remote.SSH.logLevel" = "trace";
    "remote.SSH.useExecServer" = false;
  };
}
