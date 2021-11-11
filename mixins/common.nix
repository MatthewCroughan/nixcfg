{ config, pkgs, lib, inputs, ...}:
{
  nix = {
    extraOptions =
      let empty_registry = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}''; in
      ''
        experimental-features = nix-command flakes recursive-nix
        flake-registry = ${empty_registry}
        builders-use-substitutes = true
      '';
    trustedUsers = [ "@wheel" "root" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };
}
