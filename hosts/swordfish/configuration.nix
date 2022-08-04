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
      ./modules/hercules-ci-agent.nix
      ./modules/hydroxide.nix
      ./modules/trusted-users.nix
      ./modules/jellyfin.nix
      ./modules/traefik.nix
      ./modules/libvirtd.nix
      ./modules/crater.nix
    ];

  nix.extraOptions = ''
    extra-platforms = x86_64-linux i686-linux aarch64-linux armv6l-linux armv7l-linux riscv64-linux
  '';

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

  hardware.usbWwan.enable = true;

  networking = {
    hostName = "swordfish";
  };

  systemd.enableUnifiedCgroupHierarchy = true;

  time.timeZone = "Europe/London";

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" "armv7l-linux" "armv6l-linux" "riscv64-linux" ];
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        efiInstallAsRemovable = true;
      };
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

  users.users.julianbld = {
    isNormalUser = true;
    extraGroups = [ ]; # Enable ‘sudo’ for the user.
  };

  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    tmux
    asciinema
    file
    libguestfs-with-appliance
    inputs.agenix.defaultPackage.x86_64-linux
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

