# Homepage for https://defenestrate.it
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."defenestrate.it" = {
      forceSSL = true;
      enableACME = true;
      root = ./homepage;
  };
}
