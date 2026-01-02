{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "jupyter.askForKernelRestart" = false;
    "jupyter.themeMatplotlibPlots" = false;
    ### NOTEBOOKS
    # Layout
    "notebook.cellFocusIndicator" = "border";
    "notebook.cellToolbarLocation" = {
      "default" = "right";
      "jupyter-notebook" = "right";
    };
    "notebook.codeActionsOnSave" = {
      "notebook.source.fixAll" = "explicit";
      "notebook.source.organizeImports" = "explicit";
    };
    "notebook.consolidatedRunButton" = true;
    "notebook.defaultFormatter" = "charliermarsh.ruff";
    "notebook.diff.overviewRuler" = true;
    "notebook.formatOnSave.enabled" = true;
    "notebook.lineNumbers" = "on";
    "notebook.output.fontFamily" = "FiraCode Nerd Font";
    "notebook.output.fontSize" = 9;
    "notebook.output.scrolling" = true;
    "notebook.stickyScroll.enabled" = true;
  };

}
