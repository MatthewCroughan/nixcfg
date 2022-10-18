{ pkgs, config, lib, ... }:
{
  # Needed for ZFS
  networking.hostId = "b7f4992a";
  boot = {
    supportedFilesystems = [ "zfs" ];
    # Since I'm using nixos-unstable mostly, the latest ZFS is sometimes
    # incompatible with the latest kernel.
    zfs.enableUnstable = true;
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };
}
