{ config, pkgs, inputs, ... }:

let
  swayfont = "Iosevka Bold 9";
  terminal = "${pkgs.kitty}/bin/kitty";
  light = "${pkgs.light}/bin/light";
  wofi = "${pkgs.wofi}/bin/wofi --insensitive";
  bemenu = "BEMENU_BACKEND=wayland ${pkgs.bemenu}/bin/bemenu-run -H 16 -p execute: -b --fn 'Terminus 9' --tf '#FFFFFF' --scf '#FFFFFF' --ff '#FFFFFF' --tb ''#FFFFFF --nf '#FFFFFF' --hf '#FFFFFF' --nb '#000000' --tb '#000000' --fb '#000000'";
  launcher = bemenu;
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  swayfonts = {
    names = [ "Terminus (TTF)" "FontAwesome" ];
    style = "Medium";
    size = 9.0;
  };
  swaylockcmd = "${pkgs.swaylock}/bin/swaylock -c '#000000'";
  idlecmd = pkgs.writeShellScript "swayidle.sh" ''
    ${pkgs.swayidle}/bin/swayidle \
    before-sleep "${swaylockcmd}" \
    lock "${swaylockcmd}" \
    timeout 500 "${swaylockcmd}" \
    timeout 1000 "${pkgs.systemd}/bin/systemctl suspend"
  '';
  dropdownTerminalCmd = pkgs.writeShellScript "launchkitty.sh" ''
    open=$(ps aux | grep -i "kitty --class=dropdown" | grep -v grep)
    if [[ $open -eq 0 ]]
    then
      ${pkgs.kitty}/bin/kitty --class=dropdown --detach
      until swaymsg scratchpad show
      do
        echo "Waiting for Kitty to appear..."
      done
    else
      echo "Kitty is already open"
      swaymsg "[app_id=dropdown] scratchpad show"
    fi
  '';
in
{ config = {
    home-manager.users.matthew = { pkgs, ... }: {
      wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures = {
          base = false;
          gtk = false;
        };
        xwayland = true;
        config = rec {
          inherit terminal;
#          fonts = swayfonts;
          bars = [{
            fonts = {
              names = [ "Terminus" ];
              size = 9.0;
            };
            statusCommand = "i3status-rs $HOME/.config/i3status-rust/config-top.toml";
            extraConfig = "height 16";
          }];
          focus.followMouse = "always";
          window.border = 1;
          window.commands = [
            { criteria = { app_id = "dropdown"; }; command = "floating enable"; }
            { criteria = { app_id = "dropdown"; }; command = "resize set 1000 640"; }
            { criteria = { app_id = "dropdown"; }; command = "move scratchpad"; }
            { criteria = { app_id = "dropdown"; }; command = "border pixel 1"; }
          ];
          colors.focused = { background = "#4c7899"; border = "#4c7899"; childBorder = "#4c7899"; indicator = "#2e9ef4"; text = "#ffffff"; };
          input = { "type:touchpad" = { tap = "enabled"; natural_scroll = "enabled"; }; };
          startup = [
            { always = true; command = "${pkgs.systemd}/bin/systemd-notify --ready || true"; }
            { always = true; command = "${pkgs.mako}/bin/mako --default-timeout 3000"; }
            { always = true; command = "touch $SWAYSOCK.wob && tail -n0 -f $SWAYSOCK.wob | ${pkgs.wob}/bin/wob"; }
            { always = true; command = "${pkgs.flashfocus}/bin/flashfocus"; }
            { command = "exec ${idlecmd}"; always = true; }
          ];
          modifier = "Mod4";
          keybindings = {
            "XF86MonBrightnessUp" = "exec ${light} -A 5 && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
            "XF86MonBrightnessDown" = "exec ${light} -U 5 && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
            "XF86AudioRaiseVolume" = "exec ${pamixer} -ui 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
            "XF86AudioLowerVolume" = "exec ${pamixer} -ud 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
            "XF86AudioMute" = "exec ${pamixer} --toggle-mute && ( ${pamixer} --get-mute && echo 0 > $SWAYSOCK.wob ) || ${pamixer} --get-volume > $SWAYSOCK.wob";

            "ctrl+shift+c" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";

            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+x" = "exec ${swaylockcmd}";
            "${modifier}+c" = "kill";
            "${modifier}+Shift+r" = "reload";
            "${modifier}+t" = "layout toggle tabbed split";

            "F12" = "exec ${dropdownTerminalCmd}";

            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";

            "${modifier}+Shift+h" = "move left";
            "${modifier}+Shift+j" = "move down";
            "${modifier}+Shift+k" = "move up";
            "${modifier}+Shift+l" = "move right";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+0" = "workspace number 10";

            "${modifier}+b" = "splith";
            "${modifier}+v" = "splitv";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+space" = "floating toggle";
            "${modifier}+w" = "sticky toggle";
            "${modifier}+a" = "focus parent";
            "${modifier}+d" = "exec ${launcher}";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";
            "${modifier}+Shift+0" = "move container to workspace number 10";
          };
        };
      };
    };
  };
}
