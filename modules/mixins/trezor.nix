{ config, pkgs, ... }:
{
  services = {
    trezord.enable = true;
    udev.packages = [ pkgs.trezor-udev-rules ];
  };
}
