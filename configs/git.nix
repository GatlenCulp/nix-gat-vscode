{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "git.autofetch" = true;
    "git.openRepositoryInParentFolders" = "never";
    "gitlens.ai.gitkraken.model" = "gemini:gemini-2.0-flash";
    "gitlens.ai.model" = "gitkraken";
    "gitlens.blame.fontFamily" = "FiraCode Nerd Font";
    "gitlens.currentLine.fontFamily" = "FiraCode Nerd Font";
    "gitlens.graph.dateFormat" = null;
    "gitlens.graph.dimMergeCommits" = true;
    "gitlens.graph.minimap.additionalTypes" = [ "stashes" ];
    "gitlens.graph.minimap.enabled" = false;
    "gitlens.heatmap.locations" = [
      "gutter"
      "overview"
    ];
    "gitlens.statusBar.enabled" = false;
    "gitlens.views.commitDetails.files.layout" = "list";
  };
}
