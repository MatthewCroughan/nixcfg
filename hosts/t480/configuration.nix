# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../profiles/tailscale.nix
      ../../profiles/sway.nix
      ../../profiles/steam.nix
      ../../profiles/wireless.nix
      ../../profiles/pipewire.nix
      ../../profiles/avahi.nix
      ../../mixins/obs.nix
      ../../mixins/v4l2loopback.nix
      ../../mixins/editor/vim.nix
      ../../mixins/gfx-intel.nix
      ../../mixins/common.nix
      ../../mixins/i3status.nix
      ../../mixins/fonts.nix
      ../../mixins/editor/nvim.nix
    ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # From flake-utils-plus
  nix = {
    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;
  };

  # This happens to fix a problem with the systemd service that is created as a
  # result of enabling networkd. It's not clear why it happens, but I should
  # re-evaluate whether this is necessary to set in the future.
  systemd.services.systemd-networkd-wait-online.enable = false;

  networking = {
    hostName = "t480";
    useNetworkd = true;
    wireless = {
      enable = true;
      interfaces = [ "wlp3s0" ];
    };
    useDHCP = false;
    interfaces = {
      "enp0s31f6".useDHCP = true;
      "wlp3s0".useDHCP = true;
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "false";
  };
    
  services.throttled.enable = true;

  services.logind.killUserProcesses = true;

  # Enable bluetooth for headphones
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable xdg.portal for Wayland
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs;
      [ xdg-desktop-portal-wlr ];
  };

  # Use latest kernel: https://github.com/NixOS/nixpkgs/issues/30335#issuecomment-336031992 
  boot.kernelPackages = pkgs.linuxPackages_5_14;

  # Gives access to the NUR: https://github.com/nix-community/NUR
  nixpkgs.overlays = [ inputs.nur.overlay inputs.flake-ndi.overlay ];

  # Use the systemd-boot EFI boot loader, instead of GRUB.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  # Setup ZFS requirements
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "235f593c";

  # Since I'm using nixos-unstable mostly, the latest ZFS is sometimes
  # incompatible with the latest kernel.
  boot.zfs.enableUnstable = true;

  # Set up LUKS requirements
  boot.initrd.luks.devices.crypted.device = "/dev/disk/by-label/nixos";

  # Allow trim on SSD
  boot.initrd.luks.devices.crypted.allowDiscards = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";
 
  # Set location provider
  location.provider = "geoclue2";
 
  # Enable OpenGL
  hardware.opengl.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    chromium
    vim
    tmux
    mpv
    gnumake
    htop
    inputs.agenix.defaultPackage.x86_64-linux
  ];

  # Allow proprietary software.
  nixpkgs.config.allowUnfree = true;

  # Enable Docker.
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable fingerprint reading daemon.
  services.fprintd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.matthew = {
     isNormalUser = true;
     extraGroups = [ "input" "wheel" "docker" "video" "dialout" ]; # Enable ‘sudo’ for the user.
   };

 # This value determines the NixOS release from which the default
 # settings for stateful data, like file locations and database versions
 # on your system were taken. It‘s perfectly fine and recommended to leave
 # this value at the release version of the first install of this system.
 # Before changing this value read the documentation for this option
 # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
 system.stateVersion = "20.03"; # Did you read the comment?

 # Enable power management
 powerManagement.enable = true;

 services.upower.enable = true;

 services.tlp = {
   enable = true;
   settings = {
     CPU_SCALING_GOVERNOR_ON_AC = "performance";
     STOP_CHARGE_THRESH_BAT1=95;
   };
 };

 # Udev Rule for my Gamecube Controller Adapter
 services.udev.extraRules = ''SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"'';

 networking.firewall.enable = false;

}

