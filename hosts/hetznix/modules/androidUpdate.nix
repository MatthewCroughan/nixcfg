{ config, pkgs, inputs, ... }:
{
#  systemd.services.nginx.serviceConfig.ReadOnlyPaths = [ "${inputs.self.robotnixConfigurations.pyxis.otaDir}" ];
  services = {
    nginx = {
      enable = true;
      virtualHosts."android.croughan.sh" = {
        root = "${inputs.self.robotnixConfigurations.pyxis.otaDir}";
        listen = [{
          addr = "127.0.0.1";
          port = 9999;
        }];
#        locations."/" = {
#          extraConfig = ''
#            autoindex on;
#          '';
#        };
#        locations."/android" = {
#          return = "301 https://android.croughan.sh/";
#          tryFiles = "$uri $uri/ =404";
#        };
      };
    };
  };
}
