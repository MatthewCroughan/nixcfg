{ config, pkgs, inputs, ... }:

let
  swayfont = "Iosevka Bold 9";
  barfont = "Iosevka Bold 9"; # font matches waybar-config.css
  terminal = "${pkgs.kitty}/bin/kitty";

  # idle/lock
  # TODO: test and fix/ remove this message
  swaylockcmd = "${pkgs.swaylock}/bin/swaylock -f -c '#000000'";
  idlecmd = ''${pkgs.swayidle}/bin/swayidle -w \
    before-sleep \"${swaylockcmd}\" \
    lock \"${swaylockcmd}\" \
    timeout 500 \"${swaylockcmd}\" \
    timeout 1000 \"${pkgs.systemd}/bin/systemctl suspend\"'';
in
{
  config = {
    programs.sway.enable = true; # needed for swaylock/pam stuff
    programs.sway.extraPackages = []; # empty list, defaults are bad

    environment.systemPackages = with pkgs; [
      # Add pkgs if needed
      capitaine-cursors
    ];

    home-manager.users.matthew = { pkgs, ... }: {
      wayland.windowManager.sway = {
        enable = true;
        extraConfig = builtins.readFile ../profiles/sway.conf;
        wrapperFeatures = {
          base = true; # this is the default, but be explicit for now
          gtk = true;
        };
        xwayland = true;
#        extraConfig = ''
#          seat seat0 xcursor_theme "capitaine-cursors"
#        '';
        config = rec {
          keybindings = {
            "${modifier}+x" = "${swaylockcmd}";
          };
          modifier = "Mod4";
          inherit terminal;
          fonts = [ swayfont ];
          focus.followMouse = "always";
          window.border = 4;
          window.titlebar = true;
          window.commands = [
            { criteria = { app_id = "mpv"; }; command = "sticky enable"; }
            { criteria = { app_id = "mpv"; }; command = "floating enable"; }
	  ];
          startup = [
            { always = true; command = "${pkgs.systemd}/bin/systemd-notify --ready || true"; }
            { always = true; command = "${pkgs.mako}/bin/mako"; }
            { command = "${idlecmd}"; always = true; }
          ];
        };
      };
    };
  };
}
