
# The following documents helped me understand this
# https://github.com/NixOS/nixpkgs/blob/ca4e26d1e662231d33831651c2e2ed83b1442cb7/doc/languages-frameworks/vim.section.md#managing-plugins-with-vim-plug
# https://nicknovitski.com/vim-nix-syntax

{ config, pkgs, lib, ... }:

{
  nixpkgs.config.vim.ftNix = false;
  environment.systemPackages = with pkgs; [
    (vim_configurable.customize {
      vimrcConfig.customRC = ''
        set mouse-=a
      '';
      name = "vim";
      vimrcConfig.packages.vim = 
        with pkgs.vimPlugins; { 
          start = [ vim-nix ]; 
        };
      }
    )
  ];
}


