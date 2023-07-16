{ config, pkgs, inputs, ... }:
{
  imports = with inputs.self.nixosModules; [
    ./disks.nix
    ./hardware-configuration.nix
    users-matthewcroughan
    profiles-tailscale
    profiles-sway
    profiles-fail2ban
#    profiles-steam
    profiles-wireless
    profiles-pipewire
    profiles-avahi
    mixins-obs
    mixins-v4l2loopback
    mixins-common
    mixins-i3status
    mixins-fonts
    mixins-bluetooth
    mixins-vaapi-intel-hybrid-codec
    mixins-zram
    editor-nvim
  ];

  nixpkgs.overlays = [
    (self: super: {
      sway-unwrapped = super.sway-unwrapped.override { stdenv = super.withCFlags [ "-funroll-loops" "-O3" "-march=x86-64-v3" ] super.llvmPackages_15.stdenv; };
      kitty = super.kitty.override { stdenv = super.withCFlags [ "-funroll-loops" "-O3" "-march=x86-64-v3" ] super.llvmPackages_15.stdenv; };
      nixUnstable = super.nixUnstable.override { stdenv = super.withCFlags [ "-funroll-loops" "-O3" "-march=x86-64-v3" ] super.llvmPackages_15.stdenv; };
    })
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = false;
    };
  };

  users.users.matthew.extraGroups = [ "video" ];

  nix = {
    # From flake-utils-plus
    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;
  };

  networking = {
    firewall = {
      # Syncthing ports
      allowedTCPPorts = [ 22000 ];
      allowedUDPPorts = [ 21027 22000 ];
    };
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
      # Nreal Air Glasses
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="3318", ATTRS{idProduct}=="0424", GROUP="input", MODE="0666"
      # Gamecube Controller Adapter
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
      # Xiaomi Mi 9 Lite
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="05c6", ATTRS{idProduct}=="9039", MODE="0666"
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="2717", ATTRS{idProduct}=="ff40", MODE="0666"
    '';
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        PCIE_ASPM_ON_BAT = "powersupersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_MAX_PERF_ON_AC = "100";
        CPU_MAX_PERF_ON_BAT = "30";
        STOP_CHARGE_THRESH_BAT1 = "95";
        STOP_CHARGE_THRESH_BAT0 = "95";
      };
    };
    logind.killUserProcesses = true;
  };

  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [
      "i915.modeset=1"
      "i915.fastboot=1"
      "i915.enable_guc=2"
      "i915.enable_psr=1"
      "i915.enable_fbc=1"
      "i915.enable_dc=2"
    ];
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

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time.timeZone = "Europe/London";
  location.provider = "geoclue2";

  hardware = {
    opengl.enable = true;
    trackpoint = {
      enable = true;
      sensitivity = 255;
    };
  };

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

  system.stateVersion = "22.11";
}

