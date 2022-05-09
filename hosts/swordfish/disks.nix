{ pkgs, config, lib, ... }:
{
  # Needed for ZFS
  networking.hostId = "cadb7ccb";
  boot = {
    supportedFilesystems = [ "zfs" ];
    loader.grub.mirroredBoots = [
      {
        devices = [ "/dev/disk/by-uuid/1C38-D720" ];
        path = "/boot-fallback";
      }
    ];
    # Since I'm using nixos-unstable mostly, the latest ZFS is sometimes
    # incompatible with the latest kernel.
    zfs.enableUnstable = true;
    kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;
    # Western Digital SN850s are acting weird without disabling pcie_aspm
    # https://bbs.archlinux.org/viewtopic.php?id=255535
    kernelParams = [
      "pcie_aspm=off"
      "nvme_core.default_ps_max_latency_us=0"
    ];
  };
  fileSystems = {
    "/eggshells" =
      {
        device = "eggshells";
        fsType = "zfs";
      };
    "/eggshells/archive" =
      {
        device = "eggshells/archive";
        fsType = "zfs";
      };
    };
}
