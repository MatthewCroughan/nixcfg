# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../profiles/avahi.nix
      ./modules/hercules-ci-agent.nix
      ../../mixins/editor/vim.nix
      ../../mixins/editor/nvim.nix
      ../../mixins/common.nix
      ./modules/hydroxide.nix
      ./modules/trusted-users.nix
      ./modules/tailscale.nix
      ./modules/jellyfin.nix
      ./modules/traefik.nix
      ./modules/libvirtd.nix
      ./modules/crater.nix
    ];


  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-platforms = x86_64-linux aarch64-linux armv7l-linux
    '';
  };


  fileSystems."/eggshells" =
    { device = "eggshells";
      fsType = "zfs";
    };

  fileSystems."/eggshells/archive" =
    { device = "eggshells/archive";
      fsType = "zfs";
    };

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" "armv7l-linux" ];
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        efiInstallAsRemovable = true;
        mirroredBoots = [
          { devices = [ "/dev/disk/by-uuid/1C38-D720" ];
            path = "/boot-fallback"; }
        ];
      };
    };
  };

  # Since I'm using nixos-unstable mostly, the latest ZFS is sometimes
  # incompatible with the latest kernel.
  boot.zfs.enableUnstable = true;

  systemd.enableUnifiedCgroupHierarchy = true;

  boot.kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;

  # Setup ZFS requirements  
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "cadb7ccb";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = true;
  # networking.interfaces.enp1s0f0.useDHCP = true;
  # networking.interfaces.enp1s0f1.useDHCP = true;
  # networking.enableIPv6 = true;
  #
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services.netdata = {
    enable = true;
    config = {
      global = {
        "memory mode" = "dbengine";
        "history" = 24*60*60*7; # 1 Week
      };
    };
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matthew = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  users.users.julianbld = {
    isNormalUser = true;
    extraGroups = [ ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim git tmux asciinema file libguestfs-with-appliance inputs.agenix.defaultPackage.x86_64-linux
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.hostName = "swordfish";

  # services.xserver.enable = true;
  # services.xserver.desktopManager.gnome3.enable = true;
  # services.xserver.displayManager.gdm.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

