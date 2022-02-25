{
  # Setup ZFS requirements
  networking.hostId = "8b4ae2d2";
  boot = {
    loader.grub.device = "/dev/sda";
    supportedFilesystems = [ "zfs" ];
  };
}
