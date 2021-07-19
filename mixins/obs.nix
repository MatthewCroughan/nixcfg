{ config, pkgs, ... }:

{
  config = {
    home-manager.users.matthew = { pkgs, ... }: {

#      home.file.".config/obs-studio/plugins/obs-ndi/bin/64bit/obs-ndi.so".source = "${pkgs.obs-ndi}/lib/obs-plugins/obs-ndi.so";
#      home.file.".config/obs-studio/plugins/obs-ndi/data/locale/en-US.ini".source = "${pkgs.obs-ndi}/share/obs/obs-plugins/obs-ndi/locale/en-US.ini";

      programs.obs-studio = {
        enable = true;
#        plugins = with pkgs; [
#          obs-wlrobs
#          obs-v4l2sink
#          obs-ndi
#        ];
      };
    };
  };
}
