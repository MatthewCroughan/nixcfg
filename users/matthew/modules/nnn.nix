{ config, lib, pkgs, ... }:
{
  home.sessionVariables = {
    NNN_FIFO = "$XDG_RUNTIME_DIR/nnn.fifo";
  };
  programs = {
    nnn = {
      enable = true;
      package = pkgs.nnn.override ({ withNerdIcons = true; });
      extraPackages = with pkgs; [
        bat
        exa
        fzf
        imv
        mediainfo
        ffmpegthumbnailer
      ];
      plugins = {
        src = "${pkgs.nnn.src}/plugins";
        mappings = {
          c = "fzcd";
          f = "finder";
          o = "fzopen";
          p = "preview-tui";
          t = "nmount";
          v = "imgview";
        };
      };
    };
  };
}
