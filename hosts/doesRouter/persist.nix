{
  age.identityPaths = [
    "/persist/etc/ssh/ssh_host_ed25519_key"
    "/persist/etc/ssh/ssh_host_rsa_key"
  ];
  fileSystems."/persist" = {
    device = "zroot/persist";
    fsType = "zfs";
    neededForBoot = true;
  };
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/acme"
      "/var/lib/traefik"
    ];
    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/machine-id"
    ];
  };
}
