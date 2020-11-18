{ config, pkgs, ... }:

{
  imports =
    [
      ./tmux.nix # tmux config
      ./wayland/sway.nix
    ];
}
