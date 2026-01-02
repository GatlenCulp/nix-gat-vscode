{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [
    ban.troff # troff lang, niche.
    # cweijan.vscode-office # MS Office (includes Vditor markdown editor)
    editorconfig.editorconfig # niche devops tool
    humao.rest-client
    kdl-org.kdl # KDL (niche lang)
    mathematic.vscode-pdf # preview pdfs
    vitaliymaz.vscode-svg-previewer # preview svgs
    # hediet.vscode-drawio # drawio files
    # jan-dolejsi.pddl # pddl niche lang
    # ms-vscode.live-server
    # WakaTime.vscode-wakatime # Not available
    # tyriar.luna-paint
    lov3.sagemath-enhanced
    sharat.vscode-brewfile
  ];
  settings = {
    "[eval-log]" = { };
    "[pddl]"."editor.defaultFormatter" = "jan-dolejsi.pddl";
    "pddl.selectedPlanner" = "Planning as a service (solver.planning.domains)";
  };
}
