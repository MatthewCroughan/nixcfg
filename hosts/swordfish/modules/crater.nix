{ config, lib, pkgs, ... }:
let
  matthewcroughan = builtins.getFlake "github:matthewcroughan/nixpkgs/4fc9b7816c95125e2bc80be527847a55acdcb432";
in
{
  imports = [
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/matthewcroughan/nixpkgs/4fc9b7816c95125e2bc80be527847a55acdcb432/nixos/modules/services/web-apps/crater.nix";
      sha256 = "0m7lxgf08lh54c12jzwxifzh8dm4i117c8ifz51vgawjmhfi5is3";
    })
  ];

  nixpkgs.overlays = [
    (self: super: {
      crater = matthewcroughan.outputs.legacyPackages.${super.hostPlatform.system}.crater;
    })
  ];

  services.crater.enable = true;
  services.httpd.virtualHosts.crater.listen =
    [
      {
        "port" = 8070;
      }
    ];
  services.httpd.adminAddr = "github@croughan.sh";
}
