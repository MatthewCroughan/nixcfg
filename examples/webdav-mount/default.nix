{ pkgs, lib, config, ... }:
{
  services.davfs2.enable = true;
  system.activationScripts.davfs2-secrets = ''
    echo "https://nasa.astral/remote.php/webdav/ matthewcroughan superSecretPassword" > /tmp/davfs2-secrets
    chmod 600 /tmp/davfs2-secrets
  '';

  fileSystems = {
    "/mnt/nasa" = {
      device = "https://nasa.astral/remote.php/webdav/";
      fsType = "davfs";
      options = let
        davfs2Conf = (pkgs.writeText "davfs2.conf" ''
          secrets /tmp/davfs2-secrets
          trust_ca_cert ${./certs/nasa.pem}
          trust_server_cert ${./certs/nasa.pem}
        '');
      in [ "conf=${davfs2Conf}" "x-systemd.automount" "noauto"];
    };
  };
}
