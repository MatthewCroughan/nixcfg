{ pkgs, lib, config, ... }:
let
  fqdn =
    let
      join = hostName: domain: hostName + lib.optionalString (domain != null) ".${domain}";
    in join config.networking.hostName config.networking.domain;
in {
  networking = {
    hostName = "matrix";
    domain = "defenestrate.it";
  };
  networking.firewall = {
    allowedUDPPorts = [ 5349 5350 ];
    allowedTCPPorts = [ 80 443 3478 3479 ];
  };

# Uncomment this, if you need to play around in the database temporarily as the
# root user
#  services.postgresql.authentication = "local all all trust";

  services.postgresql.package = pkgs.postgresql_13;
  services.postgresql.enable = true;
  services.postgresql.initialScript = pkgs.writeText "synapse-init.sql" ''
    CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
    CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
      TEMPLATE template0
      LC_COLLATE = "C"
      LC_CTYPE = "C";
  '';

  services.coturn = {
    enable = true;
    use-auth-secret = true;
    static-auth-secret = "CHANGE_ME";
    realm = "turn.${config.networking.domain}";
    no-tcp-relay = true;
    no-tls = true;
    no-dtls = true;
    extraConfig = ''
        user-quota=12
        total-quota=1200
        denied-peer-ip=10.0.0.0-10.255.255.255
        denied-peer-ip=192.168.0.0-192.168.255.255
        denied-peer-ip=172.16.0.0-172.31.255.255

        allowed-peer-ip=192.168.191.127
    '';
  };

  security.acme.email = "letsencrypt@croughan.sh";
  security.acme.acceptTerms = true;

  services.nginx = {
    enable = true;
    # only recommendedProxySettings and recommendedGzipSettings are strictly required,
    # but the rest make sense as well
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {
      # This host section can be placed on a different host than the rest,
      # i.e. to delegate from the host being accessible as ${config.networking.domain}
      # to another host actually running the Matrix homeserver.
      "${config.networking.domain}" = {
        enableACME = true;
        forceSSL = true;

        locations."= /.well-known/matrix/server".extraConfig =
          let
            # use 443 instead of the default 8448 port to unite
            # the client-server and server-server port for simplicity
            server = { "m.server" = "${fqdn}:443"; };
          in ''
            add_header Content-Type application/json;
            return 200 '${builtins.toJSON server}';
          '';
        locations."= /.well-known/matrix/client".extraConfig =
          let
            client = {
              "m.homeserver" =  { "base_url" = "https://${fqdn}"; };
              "m.identity_server" =  { "base_url" = "https://vector.im"; };
            };
          # ACAO required to allow element-web on any URL to request this json file
          in ''
            add_header Content-Type application/json;
            add_header Access-Control-Allow-Origin *;
            return 200 '${builtins.toJSON client}';
          '';
      };

      # Reverse proxy for Matrix client-server and server-server communication
      ${fqdn} = {
        enableACME = true;
        forceSSL = true;

        # Or do a redirect instead of the 404, or whatever is appropriate for you.
        # But do not put a Matrix Web client here! See the Element web section below.
        locations."/".extraConfig = ''
          return 404;
        '';

        # forward all Matrix API calls to the synapse Matrix homeserver
        locations."/_matrix" = {
          proxyPass = "http://[::1]:8008"; # without a trailing /
        };
      };
    };
  };
  services.matrix-synapse = {
    enable = true;
    extraConfig = ''
      experimental_features:
        spaces_enabled: true
    '';
    url_preview_enabled = true;
    turn_uris = [
      "turn:turn.${config.networking.domain}:3478?transport=udp"
      "turn:turn.${config.networking.domain}:3478?transport=tcp"
    ];
    turn_shared_secret = config.services.coturn.static-auth-secret;
    registration_shared_secret = "CHANGE_ME";
    macaroon_secret_key = "CHANGE_ME";
    server_name = config.networking.domain;
    listeners = [
      {
        port = 8008;
        bind_address = "::1";
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [
          {
            names = [ "client" "federation" "webclient" ];
            compress = false;
          }
        ];
      }
    ];
  };
  services.nginx.virtualHosts."element.${config.networking.domain}" = {
    enableACME = true;
    forceSSL = true;
    serverAliases = [
      "element.${config.networking.domain}"
    ];

    root = pkgs.element-web.override {
      conf = {
        default_server_config."m.homeserver" = {
          "base_url" = "https://${fqdn}";
          "server_name" = "${fqdn}";
        };
      };
    };
  };
}
