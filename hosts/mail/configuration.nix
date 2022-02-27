{ config, pkgs, inputs, ... }:
{
  imports = [
    ./disks.nix
    ./hardware-configuration.nix
    ./modules/mailserver.nix
    "${inputs.self}/profiles/users/matthewcroughan.nix"
    "${inputs.self}/mixins/openssh.nix"
    "${inputs.self}/mixins/common.nix"
    "${inputs.self}/profiles/fail2ban.nix"
  ];

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
