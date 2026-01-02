{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [ ];
  settings = {
    "[typst]" = {
      "editor.defaultFormatter" = "myriad-dreamin.tinymist";
      "editor.formatOnSave" = true;
      "editor.wordSeparators" = ''`~!@#$%^&*()=+[{]}\|;:'",.<>/?'';
    };
    "[typst-code]"."editor.wordSeparators" = ''`~!@#$%^&*()=+[{]}\|;:'",.<>/?'';
    "tinymist.formatterMode" = "typstyle";
    "typst-math.renderingMode" = "nothing";
    "typst-math.renderSpaces" = true;
  };
}
