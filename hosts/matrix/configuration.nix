{ config, pkgs, inputs, ... }:
{
  imports = with inputs.self.nixosModules; [
    ./disks.nix
    ./hardware-configuration.nix
    ./modules/matrix.nix
    ./modules/pleroma
    ./modules/defenestrate.it/homepage.nix
    users-deploy
    users-matthewcroughan
    mixins-openssh
    mixins-common
    mixins-gc
    mixins-zram
    profiles-fail2ban
  ];

  _module.args = {
    nixinate = {
      host = "matrix.defenestrate.it";
      sshUser = "deploy";
      buildOn = "local";
    };
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    configurationLimit = 10;
    enable = true;
  };

  networking = {
    useDHCP = false;
    defaultGateway6 = { address = "fe80::1"; interface = "ens3"; };
    interfaces.ens3 = {
      useDHCP = true;
      ipv6.addresses = [
        {
          address = "2a01:4f8:1c1c:d5c3::1";
          prefixLength = 64;
        }
     ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

