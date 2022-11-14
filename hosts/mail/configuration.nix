{ config, pkgs, inputs, ... }:
{
  imports = with inputs.self.nixosModules; [
    ./disks.nix
    ./hardware-configuration.nix
    ./modules/mailserver.nix
    users-deploy
    users-matthewcroughan
    mixins-openssh
    mixins-common
    mixins-gc
    profiles-fail2ban
  ];

  _module.args = {
    nixinate = {
      host = "mail.croughan.sh";
      sshUser = "deploy";
      buildOn = "remote";
    };
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
      };
    };
  };

  networking = {
    interfaces = {
      ens3 = {
        useDHCP = true;
        ipv6.addresses = [{
          address = "2a01:4f9:c011:cb0::1";
          prefixLength = 64;
        }];
      };
    };
    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens3";
    };
    hostName = "mail"; # Define your hostname.
    useDHCP = false;
  };

  system.stateVersion = "21.11";
}
