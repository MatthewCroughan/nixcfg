{ config, lib, inputs, ... }:

{
  age.secrets.cloudflare_api_key.file = "${inputs.self}/secrets/cloudflare_api_key.age";

  networking.firewall.allowedTCPPorts = [ 80 443 8081 ];

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
      http.middlewares.stardustxr-ci-auth.basicAuth.users = [ "stardustxr-ci:$2y$05$FgLCQSD6Zd8oG4Wrqif1..q0uxyZyPapxOEQRCFznH7yNPp.tTxO2" ];
      http = {
        services = {
          mosquitto.loadBalancer.servers = [ { url = "http://127.0.0.1:8080"; } ];
          vaultwarden.loadBalancer.servers = [ { url = "http://127.0.0.1:8222"; } ];
          androidUpdate.loadBalancer.servers = [ { url = "http://127.0.0.1:9999"; } ];
          droppers.loadBalancer.servers = [ { url = "http://127.0.0.1:9998"; } ];
          xandikos.loadBalancer.servers = [ { url = "http://127.0.0.1:${toString config.services.xandikos.port}"; } ];
          ipfs-api.loadBalancer.servers = [ { url = "http://127.0.0.1:5001"; } ];
          ipfs.loadBalancer.servers = [ { url = "http://127.0.0.1:8070"; } ];
        };
        routers = {
          mosquitto = {
            rule = "Host(`mosquitto.doesliverpool.xyz`)";
            entryPoints = [ "mosquitto-secure-websocket" ];
            service = "mosquitto";
            tls.certresolver = "letsencrypt";
          };
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
          ipfs-api-insecure = {
            rule = "Host(`ipfs-api.stardustxr.org`)";
            entryPoints = [ "web" ];
            service = "ipfs-api";
            middlewares = [ "redirect-to-https" ];
          };
          ipfs-api = {
            rule = "Host(`ipfs-api.stardustxr.org`)";
            entryPoints = [ "websecure" ];
            service = "ipfs-api";
            tls.certresolver = "letsencrypt-http01";
            middlewares = [ "stardustxr-ci-auth" ];
          };
          ipfs-insecure = {
            rule = "Host(`ipfs.stardustxr.org`)";
            entryPoints = [ "web" ];
            service = "ipfs";
            middlewares = [ "redirect-to-https" ];
          };
          ipfs = {
            rule = "Host(`ipfs.stardustxr.org`)";
            entryPoints = [ "websecure" ];
            service = "ipfs";
            tls.certresolver = "letsencrypt-http01";
          };
        };
      };
    };

    staticConfigOptions = {
      global = {
        checkNewVersion = false;
        sendAnonymousUsage = false;
      };

      accessLog = true;
      log.level = "TRACE";

      entryPoints.web.address = ":80";
      entryPoints.websecure.address = ":443";
      entryPoints.mosquitto-secure-websocket.address = ":8081";
      certificatesResolvers = {
        letsencrypt-http01.acme = {
          email = "letsencrypt@croughan.sh";
#          caServer = "https://acme-staging-v02.api.letsencrypt.org/directory";
          storage = "/var/lib/traefik/cert.json";
          httpChallenge = {
            entrypoint = "web";
          };
        };
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
