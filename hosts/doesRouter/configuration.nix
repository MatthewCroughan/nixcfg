{ config, pkgs, inputs, lib, ... }:
let
  externalInterface = "enp2s0";
  internalInterface = "enp3s0";
  # Returns 5_18 if kernel.version is 5.18.13 for example
  latestZfsKernelVersion = with builtins; (elemAt (splitVersion pkgs.zfs.latestCompatibleLinuxPackages.kernel.version) 0) + "_" + (elemAt (splitVersion pkgs.zfs.latestCompatibleLinuxPackages.kernel.version) 1);
in
{
  imports = [
    ./disks.nix
    ./persist.nix
    ./hardware-configuration.nix
    "${inputs.self}/profiles/users/deploy.nix"
    "${inputs.self}/profiles/users/matthewcroughan.nix"
    "${inputs.self}/profiles/fail2ban.nix"
#    "${inputs.self}/profiles/tailscale.nix"
    "${inputs.self}/mixins/openssh.nix"
    "${inputs.self}/mixins/common.nix"
    "${inputs.self}/mixins/gc.nix"
  ];

  boot = {
    # https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
    kernel.sysctl = {
      # https://en.wikipedia.org/wiki/SYN_cookies
      "net.ipv4.tcp_syncookies" = true;

      # Enable IPv4 forwarding
      "net.ipv4.conf.all.forwarding" = true;

      # Enable reverse path filtering
      "net.ipv4.conf.all.rp_filter" = true;
      "net.ipv4.conf.default.rp_filter" = true;

      # Disable ICMP redirects (prevent MITM attacks)
      "net.ipv4.conf.all.accept_redirects" = 0;

      # Log strange (martian) non-conformant packets
      "net.ipv4.conf.all.log_martians" = true;

      # Enable IPv6 forwarding
      "net.ipv6.conf.all.forwarding" = true;

      # By default, not automatically configure any IPv6 addresses.
      "net.ipv6.conf.all.accept_ra" = 0;
      "net.ipv6.conf.all.autoconf" = 0;
      "net.ipv6.conf.all.use_tempaddr" = 0;

      # Do not accept ICMP redirects (prevent MITM attacks)
      "net.ipv6.conf.all.accept_redirects" = 0;

      # On WAN, allow IPv6 autoconfiguration and tempory address use.
      "net.ipv6.conf.${externalInterface}.accept_ra" = 2;
      "net.ipv6.conf.${externalInterface}.autoconf" = true;
    };
    kernelPackages = pkgs.linuxKernel.packages."linux_${latestZfsKernelVersion}_hardened";
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    enableIPv6 = true;
    nat = {
      enable = true;
      inherit externalInterface;
      internalInterfaces = [ internalInterface ];
      internalIPs = [ "192.168.3.0/24" ];
    };
    firewall.allowPing = false;
    useDHCP = false;
    hostName = "nixSense";
    domain = "lan.croughan.sh";
    hosts = lib.mkForce {
      "127.0.0.1" = [ "localhost" ];
      "::1" = [ "localhost" ];
    };
    defaultGateway.address = "185.135.107.81";
    interfaces = {
      ${externalInterface}.ipv4.addresses = [
        { address = "185.135.107.83";
          prefixLength = 29;
        }
      ];
      ${internalInterface}.ipv4.addresses = [{
        address = "192.168.3.1";
        prefixLength = 24;
      }];
    };
  };

  services = {
    dnsmasq = {
      enable = true;
      servers = [ "1.1.1.1" "9.9.9.9" ];
    };
    dhcpd4 = {
      enable = true;
      interfaces = [ internalInterface ];
      extraConfig = ''
        subnet 192.168.3.0 netmask 255.255.255.0 {
          authoritative;
          option domain-name-servers 192.168.3.1, 1.1.1.1, 9.9.9.9;
          option subnet-mask 255.255.255.0;
          option broadcast-address 192.168.3.255;
          option routers 192.168.3.1;
          interface ${internalInterface};
          range 192.168.3.128 192.168.3.254;
        }
      '';
    };
    journald = {
      rateLimitBurst = 0;
      extraConfig = "SystemMaxUse=50M";
    };
  };

  # Hardening
  environment.noXlibs = true;

  system.stateVersion = "22.05";
}
