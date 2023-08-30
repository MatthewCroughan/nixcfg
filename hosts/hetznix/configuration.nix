{ config, pkgs, inputs, ... }:
{
  imports = with inputs.self.nixosModules; [
    ./disks.nix
    ./hardware-configuration.nix
#    ./modules/androidUpdate.nix
    ./modules/mosquitto.nix
    ./modules/droppers.nix
    ./modules/xandikos.nix
    ./modules/vaultwarden.nix
    ./modules/traefik.nix
    ./modules/masariBots.nix
    ./modules/ipfs.nix
    users-deploy
    users-matthewcroughan
    profiles-fail2ban
    profiles-tailscale
    mixins-gc
    mixins-openssh
    mixins-common
  ];

  _module.args = {
    nixinate = {
      host = "hetznix";
      sshUser = "deploy";
      # Since hetznix is serving my Android phone updates, it's probably
      # best if I compile this locally on a system with lots of ram.
      buildOn = "local";
    };
  };

  boot = {
    loader = {
      grub = {
        enable = true;
      };
    };
  };

  networking = {
    interfaces = {
      enp1s0 = {
        useDHCP = true;
        ipv6.addresses = [{
          address = "2a01:4ff:f0:2e70::1";
          prefixLength = 64;
        }];
      };
    };
    defaultGateway6 = {
      address = "fe80::1";
    #  interface is unnecessary when using networkd
    #  interface = "enp1s0";
    };
    hostName = "hetznix";
    useDHCP = false;
  };

  system.stateVersion = "21.11";
}
