{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./tmux.nix # tmux config
      ./firefox.nix
    ];
}
