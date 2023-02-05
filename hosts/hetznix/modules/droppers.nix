{ config, pkgs, inputs, ... }:
let
  mkMemfdDropper = (builtins.getFlake "github:matthewcroughan/nix-dropper-bundle/0cbad762e32fd35f79ed4bb8cff3c63900db6882").bundlers.${pkgs.hostPlatform.system}.memfd_create;
  droppers = map (x: mkMemfdDropper x) [
    pkgs.pkgsStatic.hello
  ];
  webRoot = pkgs.linkFarmFromDrvs "droppers-webRoot" (droppers ++ [
    (builtins.getFlake "github:nixos/nixpkgs/0874168639713f547c05947c76124f78441ea46c").legacyPackages.i686-linux.pkgsStatic.nix
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
