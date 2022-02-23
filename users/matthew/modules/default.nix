{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./kitty.nix
      ./firefox.nix
      ./syncthing.nix
      ./kanshi.nix
    ];
}
