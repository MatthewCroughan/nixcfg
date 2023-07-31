{ config, ... }:

{
  age.secrets.cloudflare_api_key.file = ../../secrets/cloudflare_api_key.age;

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  systemd.services.traefik = {
    environment = {
      CF_API_EMAIL = "cloudflare@croughan.sh";
    };
    serviceConfig = {
      EnvironmentFile = [ config.age.secrets.cloudflare_api_key.path ];
    };
  };

  services.traefik = {
    enable = true;

    dynamicConfigOptions = {
      http.middlewares.redirect-to-https.redirectscheme = {
        scheme = "https";
        permanent = true;
      };
      http = {
        services = {
          las-nixhow.loadBalancer.servers = [ { url = "http://192.168.3.99:8000"; } ];
        };
        routers = {
          las-nixhow-insecure = {
            rule = "Host(`las.nix.how`)";
            entryPoints = [ "web" ];
            service = "las-nixhow";
            middlewares = "redirect-to-https";
          };
          las-nixhow = {
            rule = "Host(`las.nix.how`)";
            entryPoints = [ "websecure" ];
            service = "las-nixhow";
            tls.certresolver = "letsencrypt";
          };
        };
      };
    };

    staticConfigOptions = {
      accessLog = true;
      log.level = "TRACE";

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

