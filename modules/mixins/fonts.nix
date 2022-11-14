{ config, pkgs, lib, ... }:
{
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
#    corefonts
    fira-code fira-code-symbols
    terminus_font
    jetbrains-mono
    powerline-fonts
    gelasio
    nerdfonts
    iosevka
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    source-code-pro
    ttf_bitstream_vera
    terminus_font_ttf
  ];
}
