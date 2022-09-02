{
  fileSystems."/persist" = {
    device = "zroot/persist";
    fsType = "zfs";
    neededForBoot = true;
  };
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/acme"
    ];
    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/machine-id"
    ];
  };
}
