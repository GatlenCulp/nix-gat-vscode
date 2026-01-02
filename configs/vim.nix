{ pkgs, ... }:
{
  extensions = with pkgs.vscode-marketplace; [
    vscodevim.vim
    xadillax.viml
    vintharas.learn-vim
  ];
  settings = {
    "vim.disableExtension" = true;
    "vim.cursorStylePerMode.insert" = "line";
    "vim.cursorStylePerMode.normal" = "block-outline";
    "vim.cursorStylePerMode.replace" = "underline";
    "vim.cursorStylePerMode.visual" = "block";
    "vim.cursorStylePerMode.visualblock" = "block";
    "vim.cursorStylePerMode.visualline" = "block";
    "vim.enableNeovim" = true;
    "vim.highlightedyank.enable" = true;
    "vim.neovimConfigPath" = "~/.config/nvim/init.vim";
    "vim.neovimUseConfigFile" = false;
    "vim.smartRelativeLine" = true;
    "vim.sneak" = true;
    "vim.statusBarColorControl" = true;
  };
}
