{ config, pkgs, inputs, ... }:
{
  imports = with inputs.self.nixosModules; [
    ./disks.nix
    ./hardware-configuration.nix
    ./modules/hercules-ci-agent.nix
    ./modules/jellyfin.nix
    ./modules/traefik.nix
    ./modules/libvirtd.nix
    ./modules/crater.nix
    users-deploy
    users-matthewcroughan
    mixins-openssh
    mixins-common
    mixins-zram
    profiles-tailscale
    profiles-fail2ban
    editor-nvim
  ];

  _module.args = {
    nixinate = {
      host = "swordfish";
      sshUser = "deploy";
      buildOn = "remote";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = true;
    };
  };

  nix.extraOptions = ''
    extra-platforms = x86_64-linux i686-linux aarch64-linux armv6l-linux armv7l-linux riscv64-linux
  '';

  nix = {
    sshServe = {
      protocol = "ssh-ng";
      enable = true;
      write = true;
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM/Y6IbpHHVmN0WX+gUmaEUEiechmHl5N9WdZY311ltP root@gabby"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKu/WO2l+jDK1uPr77S74XPNLWE5JD5iqlilq9UMXBBY root@goatlap"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2hSitdOmLziKfsJBeph5T5iUrSjRSCleJuYY8812Mh pasha@newtoncrosby"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOq9gQxVP6k8TNYgkBR+oasyEIooP3QTPmWSkyvywic6 root@t480"
      ];
    };
  };

#  hardware.usbWwan.enable = true;

  # Set the metric of the usbWwan adapter I have plugged in to 1025. This means
  # I can get seamless failover, since the default ethernet route will be
  # preferred due to its better metric. This is for seamless failover between
  # WWAN and LAN
  systemd.network.networks."98-usb-network-adapters" = {
    DHCP = "yes";
    dhcpV4Config.RouteMetric = 1025;
    networkConfig.IPv6PrivacyExtensions = "kernel";
    matchConfig.Name = "enp*s*f*u*";
  };

  networking = {
    hostName = "swordfish";
    nameservers = [ "127.0.0.53" "1.1.1.1" "8.8.8.8" ];
    defaultGateway.address = "192.168.3.1";
    interfaces.enp5s0 = {
      useDHCP = false;
      ipv4.addresses = [
        { address = "192.168.3.98";
          prefixLength = 24;
        }
      ];
    };
  };

  systemd.enableUnifiedCgroupHierarchy = true;

  time.timeZone = "Europe/London";

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" "armv7l-linux" "armv6l-linux" "riscv64-linux" ];
    loader = {
      grub = {
        configurationLimit = 20;
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

  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    tmux
    asciinema
    file
    libguestfs-with-appliance
    inputs.agenix.packages.x86_64-linux.default
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

