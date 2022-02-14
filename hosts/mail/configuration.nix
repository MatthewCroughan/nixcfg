{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/mailserver.nix
    "${inputs.self}/profiles/users/matthewcroughan.nix"
    "${inputs.self}/mixins/openssh.nix"
  ];
  nix.package = pkgs.nixFlakes;
  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
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
    hostId = "00000000";
    hostName = "mail"; # Define your hostname.
    useDHCP = false;
  };
  system.stateVersion = "21.11";
}
