{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/tailscale.nix
    ./modules/vaultwarden.nix
    ./modules/traefik.nix
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
      interface = "enp1s0";
    };
    hostId = "00000000";
    hostName = "hetznix";
    useDHCP = false;
  };
  system.stateVersion = "21.11";
}
