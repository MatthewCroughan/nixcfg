{ config, pkgs, lib, ... }:

{
  imports = [
    ../mixins/mako.nix
    ../mixins/sway.nix
    ../mixins/wlsunset.nix
  ];
  config = {


    home-manager.users.matthew = { pkgs, ... }: {
      # block auto-sway reload, Sway crashes...
      xdg.configFile."sway/config".onChange = lib.mkForce "";
    home.sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
        MOZ_USE_XINPUT2 = "1";

        #WLR_DRM_NO_MODIFIERS = "1";
        SDL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";

        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "sway";
      };

      home.packages = with pkgs; [
        wofi
        grim
        wl-clipboard
        imv
        slurp
        brightnessctl
        bemenu
        kanshi
        i3status
        wob
        light
      ];

#      xdg.configFile."sway/config".source = ./sway.conf;

    };
  };
}
