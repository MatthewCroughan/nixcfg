# Work in progress hacking on the ly tui, most of this config was taken from:
# https://gitlab.com/roosemberth/dotfiles/-/blob/dc50bb9e36613cad6612c46decaa74ea087bd66f/nixos-config/modules/display-manager-ly.nix

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = dmcfg.ly;
  dmcfg = config.services.xserver.displayManager;
  xcfg = config.services.xserver;
  mk_save = cfg.defaultUser != null;
  save_file = if ! mk_save then "" else pkgs.writeText "ly-prefs" ''
    ${cfg.defaultUser}
    ${toString cfg.defaultSessionIndex}
    '';

  lyConfig = pkgs.writeText "ly.cfg.ini" ''
load=${if mk_save then "true" else "false"}
mcookie_cmd=${pkgs.utillinux}/bin/mcookie
# An empty path variable will prevent ly from setting it
path=
restart_cmd=${pkgs.systemd}/bin/systemctl reboot
save=false
save_file=${save_file}

# service name (pam needs this set to login)
service_name=login

shutdown_cmd=${pkgs.systemd}/bin/systemctl poweroff
term_reset_cmd=${pkgs.ncurses}/bin/tput reset
tty=${toString xcfg.tty}

# wayland setup command
wayland_cmd=${lyPkg}/res/wsetup.sh
# wayland desktop environments
waylandsessions=${dmcfg.sessionData.desktops}/share/wayland-sessions

animate = true
animation = 0

x_cmd=${dmcfg.xserverBin} ${toString dmcfg.xserverArgs} -keeptty vt7 -verbose 2 -logfile /tmp/x11.log
x_cmd_setup="${dmcfg.sessionData.wrapper}"
xauth_cmd = "${dmcfg.xauthBin}"
xsessions="${dmcfg.sessionData.desktops}/share/xsessions"

${cfg.extraConfig}
    '';

  lyPkg = pkgs.callPackage ../pkgs/ly {};
in

{

  ###### interface

  options = {

    services.xserver.displayManager.ly = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable Ly as the display manager.
        '';
      };

      defaultUser = mkOption {
        type = types.nullOr types.str;
        default = null;
        example = "login";
        description = ''
          The default user to load. If you put a username here you
          get it automatically loaded into the username field, and
          the focus is placed on the password.
        '';
      };

      defaultSessionIndex = mkOption {
        type = lib.types.ints.unsigned;
        default = 0;
        example = 1;
        description = ''
          Index of the default session to load. This session will be
          preselected.
        '';
      };

      extraConfig = mkOption {
        type = types.lines;
        default = "";
        description = ''
          Extra configuration options for SLiM login manager. Do not
          add options that can be configured directly.
        '';
      };
      package = mkOption {
        default = lyPkg;
        description = "ly package to use.";
      };
    };

  };


  ###### implementation

  config = mkIf cfg.enable {
    services.xserver = {
      displayManager.job.execCmd = "exec ${lyPkg}/bin/ly -c ${lyConfig}";
      displayManager.lightdm.enable = lib.mkForce false;
    };

    systemd.services.display-manager.path = [ pkgs.ncurses ];

    systemd.services.display-manager.after = [
      "rc-local.service"
      "systemd-machined.service"
      "systemd-user-sessions.service"
      "getty@tty7.service"
      "user.slice"
    ];

    systemd.services.display-manager.serviceConfig = {
      Type = "idle";
      After = ["systemd-user-sessions.service" "plymouth-quit-wait.service" "getty@tty${toString xcfg.tty}.service"];
      StandardInput = "tty";
      ExecStart = "${lyPkg}/bin/ly -c ${lyConfig}";
      TTYPath = "/dev/tty${toString xcfg.tty}";
      TTYReset = true;
      TTYVHangup = true;
    };
  };
}

