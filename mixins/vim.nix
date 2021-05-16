# The following documents helped me understand this
# https://github.com/NixOS/nixpkgs/blob/ca4e26d1e662231d33831651c2e2ed83b1442cb7/doc/languages-frameworks/vim.section.md#managing-plugins-with-vim-plug
# https://nicknovitski.com/vim-nix-syntax

# name = "vim" makes the name of the executable 'vim'. If I set it to 'myVim'
# then I will have to run 'myVim' on the cli to access this custom version of
# Vim which is being created by vim_configurable.customize

{ config, pkgs, ... }:

{
  nixpkgs.config.vim.ftNix = false;
  environment.systemPackages = with pkgs; [
    (vim_configurable.customize {
      vimrcConfig.customRC = ''
        set mouse-=a
        set tw=80
        set fo+=t
        set wrap linebreak
        syntax on
        "" filetype plugin indent on
        set backspace=indent,eol,start
      '';
      name = "vim";
      vimrcConfig.packages.vim = 
        with pkgs.vimPlugins; { 
          start = [ vim-nix vim-surround ]; 
        };
      }
    )
  ];
}
