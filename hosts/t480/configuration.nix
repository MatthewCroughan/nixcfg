# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

#let
#  firefoxFlake = inputs.firefox.packages.${pkgs.system};
#in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./modules/wireguard.nix
#      ../../profiles/dark-theme.nix
#      ../../modules/ly.nix
      ../../profiles/tailscale.nix
      ../../profiles/sway.nix
      ../../profiles/steam.nix
      ../../profiles/wireless.nix
      ../../profiles/pipewire.nix
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
    gtkUsePortal = true;
    extraPortals = with pkgs;
      [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
  };

  # Use latest kernel: https://github.com/NixOS/nixpkgs/issues/30335#issuecomment-336031992 
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Gives access to the NUR: https://github.com/nix-community/NUR
  nixpkgs.overlays = [ inputs.nur.overlay inputs.flake-ndi.overlay ];

  # Use the systemd-boot EFI boot loader, instead of GRUB, etc.

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  # Set hostname.
  networking.hostName = "t480";

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.publish.enable = true;

  # Enables wireless support via wpa_supplicant.
  networking.wireless = {
    enable = true;
    interfaces = [ "wlan0" ];
  };
  
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

#  services.xserver.displayManager.ly.enable = true;
#  services.xserver.displayManager.lightdm.enable = true;
#  services.xserver.displayManager.sddm.enable = true;

#  services.xserver.displayManager.gdm.wayland = true;
#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.enable = true;

##services.xserver.desktopManager.gnome3.enable = true;
#services.xserver.desktopManager.xfce.enable = true;
#programs.xwayland.enable = false;

#  # Enable the X11 windowing system.
#  services.xserver.enable = false;
#  services.xserver.layout = "us";
#
#  # Enable touchpad support.
#  services.xserver.libinput.enable = true;
#
#  # Enable i3  
#  services.xserver.windowManager.i3.enable = true;

#  services.xserver = {
#    enable = false;
#
#    desktopManager = {
#      xterm.enable = false;
#    };
#   
#    displayManager = {
#        defaultSession = "none+sway";
#        lightdm.enable = true;
#    };
#
#    windowManager.i3 = {
#      enable = false;
#      extraPackages = with pkgs; [
#        dmenu #application launcher most people use
#        i3status # gives you the default i3 status bar
#        i3lock #default i3 screen locker
#        i3blocks #if you are planning on using i3blocks over i3status
#     ];
#    };
#  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     wget chromium vim tmux mpv gnumake htop inputs.agenix.defaultPackage.x86_64-linux
   ];

  # Allow proprietary software.
  nixpkgs.config.allowUnfree = true;

  # Enable Docker.
  virtualisation.docker.enable= true;

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


 # Udev Rules
   
 services.udev.extraRules = ''SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"'';

 networking.firewall.enable = false;

}

## UNUSED ##

  #nixpkgs.config.packageOverrides = pkgs: {
  #  chromium = pkgs.chromium.override {
  #    useOzone = true;
  #  };
  #};

  ## Some programs need SUID wrappers, can be configured further or are
  ## started in user sessions.
  #programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #  pinentryFlavor = "gnome3";
  #};

  ## Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ ... ];
  #networking.firewall.allowedUDPPorts = [ ... ];

  ## Or disable the firewall altogether.
  #networking.firewall.enable = false;

  #networking.networkmanager.unmanaged = [
  #   "*" "except:type:wwan" "except:type:gsm"
  #];

  ## Enable CUPS to print documents.
  #services.printing.enable = true;

  ## Enable the X11 windowing system.
  #services.xserver.enable = true;
  #services.xserver.layout = "us";
  #services.xserver.xkbOptions = "eurosign:e";

  ## Enable touchpad support.
  #services.xserver.libinput.enable = true;

  ## Enable the KDE Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
