{ config, pkgs, ... }:

{
  imports =
    [
      ./tmux.nix # tmux config
      ./neovim.nix
    ];
}
