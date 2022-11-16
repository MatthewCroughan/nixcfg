# Homepage for https://defenestrate.it
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."defenestrate.it" = {
    forceSSL = true;
    enableACME = true;
    root = ./homepage;
    locations."/.well-known/host-meta" = {
      extraConfig = ''
        return 301 https://social.defenestrate.it$request_uri;
      '';
    };
  };
}
