{ config, pkgs, inputs, ... }:
let
  mkMemfdDropper = (builtins.getFlake "github:matthewcroughan/nix-dropper-bundle/d48f936f1afc41478edd22fe9892644ab2071d41").bundlers.${pkgs.hostPlatform.system}.memfd_create;
  droppers = map (x: mkMemfdDropper x) [
    pkgs.pkgsStatic.hello
  ];
  webRoot = pkgs.linkFarmFromDrvs "droppers-webRoot" (droppers ++ [
    (builtins.getFlake "github:nixos/nixpkgs/0874168639713f547c05947c76124f78441ea46c").legacyPackages.i686-linux.pkgsStatic.nix
    inputs.nix-super.packages.x86_64-linux.nix-static
    inputs.nix-super.packages.aarch64-linux.nix-static
  ]);
in
{
  services = {
    nginx = {
      enable = true;
      virtualHosts."droppers.croughan.sh" = {
        root = webRoot;
        listen = [{
          addr = "127.0.0.1";
          port = 9998;
        }];
        locations."/" = {
          extraConfig = ''
            autoindex on;
          '';
        };
      };
    };
  };
}
