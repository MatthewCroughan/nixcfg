{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./tmux.nix
      ./kitty.nix
      ./firefox.nix
      ./syncthing.nix
      ./kanshi.nix
    ];
}
