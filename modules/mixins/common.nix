{ config, pkgs, lib, inputs, ...}:
{
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  nix = {
    settings = {
      trusted-users = [ "@wheel" "root" "nix-ssh" ];
      auto-optimise-store = true;
    };
    package = pkgs.nixVersions.unstable;
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

  nixpkgs.overlays = [
    (final: prev: {
      grub2 = inputs.nixpkgs.legacyPackages.${pkgs.hostPlatform.system}.grub2.overrideAttrs (old: {
        patches = old.patches ++ [
          (pkgs.fetchpatch {
            url = "https://github.com/BrainSlayer/grub/commit/9227b76fb547e2402b77b0f0a132c84242aaa9bd.patch";
            hash = "sha256-ILyJRwIlE8uj9fM2LBHNPoCm4PszjtZECTueYtikEGE=";
          })
        ];
      });
    })
  ];
}
