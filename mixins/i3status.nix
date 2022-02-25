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
            display_type = "memory";
            format_mem = "{mem_used_percents}";
            format_swap = "{swap_used_percents}";
            theme_overrides = {
              idle_bg = "#00223f";
            };
          }
          {
            block = "cpu";
            interval = 1;
            format = "{barchart} {utilization} {frequency}";
          }
          {
            block = "sound";
            theme_overrides = {
              idle_bg = "#00223f";
            };
          }
          {
            block = "battery";
            format = "{percentage} {time}";
          }
          {
            block = "net";
            format = "{ssid} {signal_strength} {ip} {speed_down;K*b} {speed_up;K*b}";
            interval = 5;
            theme_overrides = {
              idle_bg = "#00223f";
            };
          }
          {
            block = "time";
            interval = 1;
            format = "%F %T";
            icons_format = " ";
          }
        ];
        theme = "space-villain";
        icons = "none";
      };
    };
  };
}
