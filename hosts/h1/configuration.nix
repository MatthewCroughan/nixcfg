{ config, pkgs, inputs, ... }:
{
  imports =
    [
      "${inputs.self}/profiles/avahi.nix"
      "${inputs.self}/profiles/users/deploy.nix"
      "${inputs.self}/profiles/users/matthewcroughan.nix"
      "${inputs.self}/mixins/openssh.nix"
      "${inputs.self}/mixins/editor/nvim.nix"
      "${inputs.self}/mixins/common.nix"
      "${inputs.self}/profiles/fail2ban.nix"
      ./disks.nix
      ./hardware-configuration.nix
    ];

  services.tailscale.enable = true;

  nix = {
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
    # trace: warning: Strict reverse path filtering breaks Tailscale exit node
    # use and some subnet routing setups. Consider setting
    # `networking.firewall.checkReversePath` = 'loose'
    firewall.checkReversePath = "loose";
    hostName = "h1";
  };

  time.timeZone = "Europe/London";

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" "armv7l-linux" "armv6l-linux" "riscv64-linux" ];
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

