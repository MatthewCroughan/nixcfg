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
      ../../profiles/sway.nix
      ../../profiles/wireless.nix
      ../../mixins/obs.nix
      ../../mixins/v4l2loopback.nix
    ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # Enable pipewire, attempted to get browser screensharing working
  services.pipewire.enable = true;

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
  nixpkgs.overlays = [ inputs.nur.overlay ];

  # Use the systemd-boot EFI boot loader, instead of GRUB, etc.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set hostname.
  networking.hostName = "t480";

  # Enables wireless support via wpa_supplicant.
  networking.wireless.enable = true;
  
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
  programs.light.enable = true;

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

  #services.xserver.desktopManager.xfce.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.gdm.enable = true;

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
     wget chromium vim rnix-lsp tmux mpv gnumake htop vimPlugins.vim-addon-nix
   ];

  # Allow proprietary software.
  nixpkgs.config.allowUnfree = true;

  # Enable Docker.
  virtualisation.docker.enable= true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable fingerprint reading daemon.
  services.fprintd.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = true;



  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.matthew = {
     isNormalUser = true;
     extraGroups = [ "input" "wheel" "docker" "video" ]; # Enable ‘sudo’ for the user.
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
 services.tlp.enable = true; 

 # Udev Rules
   
 services.udev.extraRules = ''SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"'';

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
