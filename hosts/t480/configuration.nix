# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./modules
#      ./sway.nix
#      ./wayland.nix
#      ./cachix.nix
    ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "t480"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configures a list of networks I want to connect to.
  networking.wireless.networks.bebop.pskRaw = "0c89c6e287005f99efda5199d432f94cf8d08ea7925ba2d24eef24e268aabe67";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Setup ZFS requirements
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "235f593c";

  # Install sway
  programs.sway.enable = true;

  # Set up LUKS requirements
  boot.initrd.luks.devices.crypted.device = "/dev/disk/by-label/nixos";

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

  # Configure Iris Graphics
  # Change MESA_LOADER_DRIVER_OVERRIDE to "iris"
  # when https://bugs.launchpad.net/ubuntu/+source/mesa/+bug/1877879 is fixed
  environment.variables = {
      MESA_LOADER_DRIVER_OVERRIDE = "iris";
    };
    #hardware.opengl.package = (pkgs.mesa.override {
    #  galliumDrivers = [ "virgl" "swrast" "iris" ];
    #}).drivers;

#  # Enable the X11 windowing system.
#  services.xserver.enable = true;
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

  services.pipewire.enable=true;

  xdg.portal.enable = true;
  xdg.portal.gtkUsePortal = true;
  xdg.portal.extraPortals = with pkgs;
    [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     wget vim firefox mpv htop
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable= true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.matthew = {
     isNormalUser = true;
     extraGroups = [ "input" "wheel" "docker" ]; # Enable ‘sudo’ for the user.
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

services.udev.extraRules = ''SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"'';

}
