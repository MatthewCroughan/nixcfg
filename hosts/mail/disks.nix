{
  # Setup ZFS requirements
  networking.hostId = "00000000";
  boot = {
    loader.grub.device = "/dev/sda";
    supportedFilesystems = [ "zfs" ];
  };
}
