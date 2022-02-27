{ config, pkgs, lib, inputs, ...}:
{
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  nix = {
    package = pkgs.nixUnstable;
    extraOptions =
      let empty_registry = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}''; in
      ''
        experimental-features = nix-command flakes
        flake-registry = ${empty_registry}
        builders-use-substitutes = true
      '';
    trustedUsers = [ "@wheel" "root" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };
}
