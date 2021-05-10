{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Terminus (TTF)";
      package = pkgs.terminus_font_ttf;
      size = 9;
    }; 
    settings = {
      enable_audio_bell = false;
    };
  };
}
