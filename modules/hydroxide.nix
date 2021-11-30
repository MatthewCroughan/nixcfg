# Adapted from https://github.com/bqv/rc/blob/87eb318ef30d914e6a2a12ea821cede6624666b4/modules/services/hydroxide/default.nix

# I did have a bunch of code and ideas for accessing auth.json as a secret
# which are included below the code. However, this program rotates auth.json
# and mutates it every time it is started. So there is nothing that can be
# done. The login process could be automated if one disabled 2fa on Protonmail,
# since we could automatically run 'hydroxide auth <username>' every single
# time.

{ config, lib, pkgs, ... }:

let
  cfg = config.services.hydroxide;
in {
  options.services.hydroxide = {
    enable = lib.mkEnableOption "hydroxide";

    host = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      description = ''
        Host to bind to
      '';
    };
    port = lib.mkOption {
      type = with lib.types; nullOr int;
      default = null;
      description = ''
        Port to bind to
      '';
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hydroxide;
      defaultText = "pkgs.hydroxide";
      description = ''
        Which package to use.
      '';
    };

    dataDir = lib.mkOption {
      default = "/var/lib/hydroxide";
      type = lib.types.str;
    };

  };

  config = lib.mkIf cfg.enable {
    systemd.services.hydroxide = {
      script = let
        hostOpts = if isNull cfg.host then "" else let
          inherit (cfg) host;
        in "-imap-host ${host} -smtp-host ${host} -carddav-host ${host}";
        portOpts = if isNull cfg.port then "" else let
          inherit (cfg) port;
        in "-imap-port ${port} -smtp-port ${port} -carddav-port ${port}";
        args = lib.concatStringsSep " " [ hostOpts portOpts ];
        generateStateScript = pkgs.writeScript "generateHydroxideState" ''
          XDG_CONFIG_HOME=${cfg.dataDir} ${cfg.package}/bin/hydroxide auth "$1"
          chown -R hydroxide:hydroxide ${cfg.dataDir}/hydroxide
        '';
        nagMessage = pkgs.writeText "nagMessage" ''
          ################################################################################
                       "Hydroxide annoyingly requires you to generate some
                       initial state that would be pointless to encode in Nix.

                       In order to generate this state, run:

                       ${generateStateScript} <protonmail-username>

                       Then restart the systemd service.
          ################################################################################
        '';
      in
      ''
        ${pkgs.coreutils}/bin/cat ${nagMessage}
        ${cfg.package}/bin/hydroxide ${args} serve
      '';
      enable = true;
      after = [ "network.target" ];
      description = "Hydroxide bridge server";
      environment.XDG_CONFIG_HOME = "${cfg.dataDir}";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        DynamicUser = true;
        StateDirectory = "hydroxide";
        Restart = "always";
        RestartSec = 15;
      };
    };
  };
}

# secretAuth Notes
#
# This uses systemd LoadCredential to get the secret file, then uses
# systemd.services.<name>.script to install that secret from the
# CREDENTIALS_DIRECTORY.
#
# ...
#    secretAuthFile = lib.mkOption {
#      type = with lib.types; nullOr path;
#      default = null;
#      description = ''
#        Path to a secret auth.json file for Hydroxide.
#      '';
#    };
#    systemd.services.hydroxide = {
#      script = let
#        hostOpts = if isNull cfg.host then "" else let
#          inherit (cfg) host;
#        in "-imap-host ${host} -smtp-host ${host} -carddav-host ${host}";
#        portOpts = if isNull cfg.port then "" else let
#          inherit (cfg) port;
#        in "-imap-port ${port} -smtp-port ${port} -carddav-port ${port}";
#        args = lib.concatStringsSep " " [ hostOpts portOpts ];
#      in
#      ''
#        ${pkgs.coreutils}/bin/install -D --owner=hydroxide --mode=700 -T ''${CREDENTIALS_DIRECTORY}/hydroxideAuth ${cfg.dataDir}/hydroxide/auth.json
#        ${cfg.package}/bin/hydroxide ${args} serve
#      '';
#      serviceConfig = {
#        LoadCredential = lib.optionalString (cfg.secretAuthFile != null) "hydroxideAuth:${cfg.secretAuthFile}";
#      };
#   };
# ...
