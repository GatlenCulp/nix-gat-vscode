{ pkgs, ... }:
{
  # extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "cursor.composer.collapsePaneInputBoxPills" = true;
    "cursor.composer.shouldChimeAfterChatFinishes" = true;
    "cursor.composer.textSizeScale" = 1.15;
    "cursor.cpp.disabledLanguages" = [
      "plaintext"
      "markdown"
      "scminput"
    ];
    "cursor.cpp.enablePartialAccepts" = true;
    "cursor.general.enableShadowWorkspace" = true;
  };
}
