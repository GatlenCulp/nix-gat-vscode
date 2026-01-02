{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [
    anthropic.claude-code
  ];

  settings = {
    "claudeCode.useTerminal" = true;
  };
}
