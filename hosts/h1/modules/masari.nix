{ config, pkgs, lib, ... }:
let
  masari = (builtins.getFlake "github:matthewcroughan/nixpkgs/ad3282e68cc3c0591e51cdf86065320cbc2afc87").legacyPackages.x86_64-linux.masari;
in
{
  services.xmrig = {
    enable = true;
    settings = {
      cpu = true;
      opencl = false;
      cuda = false;
      pools = [{
        daemon = true;
        algo = "cn/half";
        url = "127.0.0.1:38081";
        user = "5hQ1knPUZ5KFauE426piQZWEohf2diB5VV6wBWDUoy6qKZ6BHV8cXvgdqsfwgMydyg2KQJucE9q9SZU99aqGkPkj1vystAd";
      }];
    };
  };
  systemd.services.masari = {
    description = "Masari Daemon";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    environment.HOME = "/var/lib/masari";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${masari}/bin/masarid --non-interactive --db-sync-mode fastest:async:10000";
      Restart = "always";
      DynamicUser = true;
      StateDirectory = "masari";
      SuccessExitStatus = [ 0 1 ];
    };
  };
}
