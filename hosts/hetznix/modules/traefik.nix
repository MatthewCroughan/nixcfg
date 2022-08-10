{ config, lib, inputs, ... }:

{
  age.secrets.cloudflare_api_key.file = "${inputs.self}/secrets/cloudflare_api_key.age";

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  systemd.services.traefik = {
    environment = {
      CF_API_EMAIL = "cloudflare@croughan.sh";
    };
    serviceConfig = {
      EnvironmentFile = config.age.secrets.cloudflare_api_key.path;
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
          vaultwarden.loadBalancer.servers = [ { url = "http://127.0.0.1:8222"; } ];
          androidUpdate.loadBalancer.servers = [ { url = "http://127.0.0.1:9999"; } ];
          droppers.loadBalancer.servers = [ { url = "http://127.0.0.1:9998"; } ];
          xandikos.loadBalancer.servers = [ { url = "http://127.0.0.1:${toString config.services.xandikos.port}"; } ];
        };
        routers = {
          xandikos-insecure = {
            rule = "Host(`xandikos.croughan.sh`)";
            entryPoints = [ "web" ];
            service = "xandikos";
            middlewares = "redirect-to-https";
          };
          xandikos = {
            rule = "Host(`xandikos.croughan.sh`)";
            entryPoints = [ "websecure" ];
            service = "xandikos";
            tls.certresolver = "letsencrypt";
          };
          androidUpdate-insecure = {
            rule = "Host(`android.croughan.sh`)";
            entryPoints = [ "web" ];
            service = "androidUpdate";
            middlewares = "redirect-to-https";
          };
          androidUpdate = {
            rule = "Host(`android.croughan.sh`)";
            entryPoints = [ "websecure" ];
            service = "androidUpdate";
            tls.certresolver = "letsencrypt";
          };
          droppersInsecure = {
            rule = "Host(`droppers.croughan.sh`)";
            entryPoints = [ "web" ];
            service = "droppers";
            middlewares = "redirect-to-https";
          };
          droppers = {
            rule = "Host(`droppers.croughan.sh`)";
            entryPoints = [ "websecure" ];
            service = "droppers";
            tls.certresolver = "letsencrypt";
          };
          vaultwarden-insecure = {
            rule = "Host(`vaultwarden.croughan.sh`)";
            entryPoints = [ "web" ];
            service = "vaultwarden";
            middlewares = "redirect-to-https";
          };
          vaultwarden = {
            rule = "Host(`vaultwarden.croughan.sh`)";
            entryPoints = [ "websecure" ];
            service = "vaultwarden";
            tls.certresolver = "letsencrypt";
          };
        };
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
