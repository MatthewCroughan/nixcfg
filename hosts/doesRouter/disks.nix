{ config, pkgs, lib, ... }:
{
  # Setup ZFS requirements
  networking.hostId = "00000000";
  boot = {
    supportedFilesystems = [ "zfs" "vfat" ];
    initrd.postDeviceCommands = lib.mkAfter ''
      zfs rollback -r zroot/root@blank
    '';
  };
}
