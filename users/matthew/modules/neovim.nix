{ config, pkgs, libs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = builtins.readFile ./init.vim;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      # nvim-luadev
      # vimspector
      completion-nvim
      fzf-vim
      fzfWrapper
      indentLine
      lightline-vim
      neoformat
      nvim-lspconfig
      onedark-vim
      splitjoin-vim
      vim-commentary
      vim-dirvish
      vim-dispatch
      vim-easy-align
      vim-eunuch
      vim-fugitive
      vim-gitgutter
      vim-gutentags
      vim-polyglot
      vim-repeat
      vim-rhubarb
      vim-sensible
      vim-sleuth
      vim-slime
      vim-surround
      vim-tmux-navigator
      vim-unimpaired
      vim-vinegar
      vimtex
    ];
    extraPackages = with pkgs; [
      rnix-lsp
      gopls
      neovim-remote
      luajitPackages.lua-lsp
      nodePackages.pyright
    ];
  };
}
