{ pkgs, inputs, config, ... }:
{
  age.secrets.pleroma = {
    file = "${inputs.self}/secrets/pleroma.age";
    owner = "pleroma";
  };

  systemd.services = {
    pleroma-db-alter = {
      before = [ "pleroma.service" ];
      after = [ "postgresql.service" ];
      serviceConfig =  {
        Type = "oneshot";
        ExecStart="${config.services.postgresql.package}/bin/psql -U postgres -c 'alter database pleroma owner to pleroma'";
        User = "postgres";
      };
    };
    pleroma = {
      requires = [ "pleroma-db-alter.service" ];
      path = [ pkgs.exiftool ];
    };
  };

  services = {
    pleroma = {
      package = pkgs.callPackage ./pleroma {};
      enable = true;
      configs = [(pkgs.callPackage ./pleroma.exs.nix {})];
      secretConfigFile = config.age.secrets.pleroma.path;
    };

    postgresql = {
      ensureDatabases = [ "pleroma" ];
      ensureUsers = [{
        name = "pleroma";
        ensurePermissions = { "DATABASE pleroma" = "ALL PRIVILEGES"; };
      }];
    };

    nginx.virtualHosts."social.defenestrate.it" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:4000";
        recommendedProxySettings = false;

        extraConfig = ''
          etag on;
          gzip on;

          add_header 'Access-Control-Allow-Origin' '*' always;
          add_header 'Access-Control-Allow-Methods' 'POST, PUT, DELETE, GET, PATCH, OPTIONS' always;
          add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type, Idempotency-Key' always;
          add_header 'Access-Control-Expose-Headers' 'Link, X-RateLimit-Reset, X-RateLimit-Limit, X-RateLimit-Remaining, X-Request-Id' always;
          if ($request_method = OPTIONS) {
            return 204;
          }
          add_header X-XSS-Protection "1; mode=block";
          add_header X-Permitted-Cross-Domain-Policies none;
          add_header X-Frame-Options DENY;
          add_header X-Content-Type-Options nosniff;
          add_header Referrer-Policy same-origin;
          add_header X-Download-Options noopen;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_set_header Host $host;

          client_max_body_size 16m;
        '';
      };
    };
  };
}
