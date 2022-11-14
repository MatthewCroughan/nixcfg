{ config, pkgs, lib, inputs, ...}:
{
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  nix = {
    settings.trusted-users = [ "@wheel" "root" "nix-ssh" ];
    package = pkgs.nixUnstable;
    extraOptions =
      let empty_registry = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}''; in
      ''
        experimental-features = nix-command flakes
        flake-registry = ${empty_registry}
        builders-use-substitutes = true
      '';
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };
}
