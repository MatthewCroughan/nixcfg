{ config, lib, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  systemd.services.traefik = {
    environment = { 
      CF_API_EMAIL = "cloudflare@croughan.sh";
    };
  };

  services.traefik = {
    enable = true;

    dynamicConfigOptions = {
      http.middlewares.redirect-to-https.redirectscheme = {
        scheme = "https";
        permanent = true;
      };
      http.routers.jellyfin-insecure = {
        rule = "Host(`jellyfin.gamecu.be`)";
        entryPoints = [ "web" ];
        service = "jellyfin";
        middlewares = "redirect-to-https";
      };
      http.routers.jellyfin = {
        rule = "Host(`jellyfin.gamecu.be`)";
        entryPoints = [ "websecure" ];
        service = "jellyfin";
        tls.certresolver = "letsencrypt";
      };

      http.services.jellyfin = {
        loadBalancer.servers = [{
          url = "http://127.0.0.1:8096";
        }];
      };
    };

    staticConfigOptions = {
      global = {
        checkNewVersion = false;
        sendAnonymousUsage = false;
      };

      entryPoints.web.address = ":80";
      entryPoints.websecure.address = ":443";

      certificatesResolvers = {
        letsencrypt.acme = {
          email = "letsencrypt@croughan.sh";
#          caServer = "https://acme-staging-v02.api.letsencrypt.org/directory";
          storage = "/var/lib/traefik/cert.json";
          dnsChallenge = {
            provider = "cloudflare";
            delayBeforeCheck = 0;
          };
        };
      };
    };
  };
}
