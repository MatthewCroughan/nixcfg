{ config, lib, pkgs, ... }:
let
  matthewcroughan = builtins.getFlake "github:matthewcroughan/nixpkgs/eb02ba188d55210d3478b924387edbbb04358f11";
  craterModule = "${matthewcroughan}/nixos/modules/services/web-apps/crater.nix";
  craterOverlay =
    (self: super: {
      crater = matthewcroughan.outputs.legacyPackages.${super.hostPlatform.system}.crater;
    });
  makeCraterContainer = port: {
    extraFlags = [ "-U" ];
    autoStart = true;
    ephemeral = false;
    config = { config, pkgs, ... }: {
      imports = [
        craterModule
      ];
      nixpkgs.overlays = [
        craterOverlay
      ];
      networking.firewall.allowedTCPPorts = [ port ];
      services = {
        crater.enable = true;
        httpd = {
          virtualHosts.crater.listen =
            [
              {
                "port" = port;
              }
            ];
          adminAddr = "github@croughan.sh";
        };
      };
    };
  };
in
{

  imports = [ craterModule ];
  nixpkgs.overlays = [ craterOverlay ];

  services.crater.enable = true;
  services.httpd.virtualHosts.crater.listen =
    [
      {
        "port" = 8070;
      }
    ];
  services.httpd.adminAddr = "github@croughan.sh";

  containers = {
    craterNixinator = makeCraterContainer 8060;
  };
}
