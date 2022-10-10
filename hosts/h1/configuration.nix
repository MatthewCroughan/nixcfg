{ config, pkgs, inputs, ... }:
{
  imports =
    [
      "${inputs.self}/profiles/avahi.nix"
      "${inputs.self}/profiles/users/deploy.nix"
      "${inputs.self}/profiles/users/matthewcroughan.nix"
      "${inputs.self}/profiles/tailscale.nix"
      "${inputs.self}/mixins/openssh.nix"
      "${inputs.self}/mixins/editor/nvim.nix"
      "${inputs.self}/mixins/common.nix"
      "${inputs.self}/profiles/fail2ban.nix"
      ./disks.nix
      ./hardware-configuration.nix
    ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    sshServe = {
      protocol = "ssh-ng";
      enable = true;
      write = true;
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM38GVfgjAWLVRcIJld+Cv4dEg1ais4JSrKjh8dmb9vg julian@goatlap"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2hSitdOmLziKfsJBeph5T5iUrSjRSCleJuYY8812Mh pasha@newtoncrosby"
      ];
    };
  };

  networking = {
    hostName = "h1";
  };

  time.timeZone = "Europe/London";

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  services = {
    netdata = {
      enable = true;
      config = {
        global = {
          "memory mode" = "dbengine";
          "history" = 24*60*60*7; # 1 Week
        };
      };
    };
  };

  system.stateVersion = "22.11";
}

