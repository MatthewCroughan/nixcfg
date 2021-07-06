{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./tmux.nix # tmux config
      ./kitty.nix
      ./firefox.nix
      ./syncthing.nix
      ./kanshi.nix
    ];
}
