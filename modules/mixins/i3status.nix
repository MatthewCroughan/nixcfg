{ pkgs, config, ... }:
{
  home-manager.users.matthew.programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        blocks = [
          {
            block = "custom";
            command = "${pkgs.rsstail}/bin/rsstail rsstail -n 1 -1 -N -u https://github.com/nixos/nixpkgs/commits/master.atom";
            interval = 60;
          }
          {
            block = "memory";
            format = " $icon $mem_used_percents ";
            format_alt = " $icon $swap_used_percents ";
            theme_overrides = {
              idle_bg = "#00223f";
            };
          }
          {
            block = "cpu";
            interval = 1;
            format = " $barchart $utilization $frequency ";
          }
          {
            block = "sound";
            theme_overrides = {
              idle_bg = "#00223f";
            };
          }
          {
            block = "battery";
            device = "BAT1";
            format = " $icon $percentage $time $power ";
          }
          {
            block = "net";
            format = " $icon $ssid $signal_strength $ip ↓$speed_down ↑$speed_up ";
            interval = 2;
            theme_overrides = {
              idle_bg = "#00223f";
            };
          }
          {
            block = "time";
            interval = 1;
            format = " $timestamp.datetime(f:'%F %T') ";
          }
        ];
        theme = "space-villain";
        icons = "none";
      };
    };
  };
}
