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
      systemd.tmpfiles.rules = [
        "L+ ${config.services.crater.dataDir}/public/storage 0755 ${config.services.crater.user} ${config.services.crater.group} - ${pkgs.crater}/storage/app/public"
      ];
      imports = [
        craterModule
      ];
      systemd.services.phpfpm-crater.postStart = ''
        until [[ -s ${config.services.crater.dataDir}/database.sqlite && $(${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "select credentials from file_disks;") ]]
        do
          sleep 1
          echo "DATABASE IS FUCKING EMPTY"
        done
        STORAGE_PUBLIC=`${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "select credentials from file_disks where id=1;" | ${pkgs.jq}/bin/jq -r | ${pkgs.jq}/bin/jq '.root = "${config.services.crater.dataDir}/storage/app/public"' | ${pkgs.jq}/bin/jq -c`
        STORAGE=`${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "select credentials from file_disks where id=2;" | ${pkgs.jq}/bin/jq -r | ${pkgs.jq}/bin/jq '.root = "${config.services.crater.dataDir}/storage/app"' | ${pkgs.jq}/bin/jq -c`

        ${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "UPDATE file_disks SET credentials = '$STORAGE_PUBLIC' where id=1;"
        ${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "UPDATE file_disks SET credentials = '$STORAGE' where id=2;"
      '';
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

  systemd.services.phpfpm-crater.postStart = ''
    until [[ -s ${config.services.crater.dataDir}/database.sqlite && $(${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "select credentials from file_disks;") ]]
    do
      sleep 1
      echo "DATABASE IS FUCKING EMPTY"
    done
    STORAGE_PUBLIC=`${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "select credentials from file_disks where id=1;" | ${pkgs.jq}/bin/jq -r | ${pkgs.jq}/bin/jq '.root = "${config.services.crater.dataDir}/storage/app/public"' | ${pkgs.jq}/bin/jq -c`
    STORAGE=`${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "select credentials from file_disks where id=2;" | ${pkgs.jq}/bin/jq -r | ${pkgs.jq}/bin/jq '.root = "${config.services.crater.dataDir}/storage/app"' | ${pkgs.jq}/bin/jq -c`

    ${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "UPDATE file_disks SET credentials = '$STORAGE_PUBLIC' where id=1;"
    ${pkgs.sqlite}/bin/sqlite3 ${config.services.crater.dataDir}/database.sqlite "UPDATE file_disks SET credentials = '$STORAGE' where id=2;"
  '';

  containers = {
    craterNixinator = makeCraterContainer 8060;
  };
}
