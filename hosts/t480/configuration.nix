{ config, pkgs, inputs, ... }:
{
  imports =
    [
      ./disks.nix
      ./hardware-configuration.nix
      "${inputs.self}/profiles/users/matthewcroughan.nix"
      "${inputs.self}/profiles/tailscale.nix"
      "${inputs.self}/profiles/sway.nix"
      "${inputs.self}/profiles/fail2ban.nix"
#      "${inputs.self}/profiles/steam.nix"
      "${inputs.self}/profiles/wireless.nix"
      "${inputs.self}/profiles/pipewire.nix"
      "${inputs.self}/profiles/avahi.nix"
      "${inputs.self}/mixins/openssh.nix"
      "${inputs.self}/mixins/obs.nix"
      "${inputs.self}/mixins/v4l2loopback.nix"
      "${inputs.self}/mixins/editor/vim.nix"
      "${inputs.self}/mixins/gfx-intel.nix"
      "${inputs.self}/mixins/common.nix"
      "${inputs.self}/mixins/i3status.nix"
      "${inputs.self}/mixins/fonts.nix"
      "${inputs.self}/mixins/editor/nvim.nix"
    ];

  users.users.matthew.extraGroups = [ "video" ];

  nix = {
    # From flake-utils-plus
    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;
  };

  # This happens to fix a problem with the systemd service that is created as a
  # result of enabling networkd. It's not clear why it happens, but I should
  # re-evaluate whether this is necessary to set in the future.
  systemd.services.systemd-networkd-wait-online.enable = false;

  networking = {
    firewall.trustedInterfaces = [ "tailscale0" ];
    hostName = "t480";
    useNetworkd = true;
    wireless = {
      userControlled.enable = true;
      enable = true;
      interfaces = [ "wlp3s0" ];
    };
    useDHCP = false;
    interfaces = {
      "enp0s31f6".useDHCP = true;
      "wlp3s0".useDHCP = true;
    };
  };

  services = {
    udev.extraRules = ''
      # Gamecube Controller Adapter
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
      # Xiaomi Mi 9 Lite
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="05c6", ATTRS{idProduct}=="9039", MODE="0666"
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="2717", ATTRS{idProduct}=="ff40", MODE="0666"
    '';
    # Power management
    upower.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        STOP_CHARGE_THRESH_BAT1=95;
        STOP_CHARGE_THRESH_BAT0=95;
      };
    };
    resolved = {
      enable = true;
      dnssec = "false";
    };
    logind.killUserProcesses = true;
  };

  # Enabule bluetooth for headphones
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  boot = {
    # Use latest kernel: https://github.com/NixOS/nixpkgs/issues/30335#issuecomment-336031992
    kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;
    # Use the systemd-boot EFI boot loader, instead of GRUB.
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
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
    git
    inputs.agenix.defaultPackage.x86_64-linux
  ];

  # Allow proprietary software.
  nixpkgs.config.allowUnfree = true;

 # This value determines the NixOS release from which the default
 # settings for stateful data, like file locations and database versions
 # on your system were taken. It‘s perfectly fine and recommended to leave
 # this value at the release version of the first install of this system.
 # Before changing this value read the documentation for this option
 # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
 system.stateVersion = "20.03"; # Did you read the comment?
}

