{ pkgs, config, lib, ... }:
{
  services.zfs.autoScrub.enable = true;
  networking.hostId = "235f593c";
  boot = {
    # Setup ZFS requirements
    supportedFilesystems = [ "zfs" ];
    # Since I'm using nixos-unstable mostly, the latest ZFS is sometimes
    # incompatible with the latest kernel.
    zfs.enableUnstable = true;
    # Set up LUKS requirements
    initrd = {
      luks.devices.crypted = {
        device = "/dev/disk/by-label/nixos";
        # Allow trim on SSD
        allowDiscards = true;
      };
    };
  };
}
