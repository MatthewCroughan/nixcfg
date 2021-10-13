{ config, lib, pkgs, ... }:
let
  matthewcroughan = builtins.getFlake "github:matthewcroughan/nixpkgs/97b7da1dd6f7ff649a4071bf9ac28622544cf91e";
in
{
  imports = [
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/matthewcroughan/nixpkgs/97b7da1dd6f7ff649a4071bf9ac28622544cf91e/nixos/modules/services/web-apps/crater.nix";
      sha256 = "18sxvwwwpz9x2rjaj5b031ddp6vqxxi9mbig4wk8bdrxhb9mi7df";
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
