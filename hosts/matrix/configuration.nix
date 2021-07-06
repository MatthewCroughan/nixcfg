{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/matrix.nix
      ./modules/zram.nix
      ./profiles/ssh.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

#  networking.hostName = "hetznix"; # Define your hostname.

  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  # Setup ZFS requirements
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "8b4ae2d2";

  users.users.matthew = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiBSVCGJPjTnWUSjkZa6ow0hHZuJ5HOynU3Nx/b3VhdBikPa5ctcQ1nHQW662EIR3qgOxZtNl+ch2XClqIJ48WqwlfFONF/LjbDMITs5FQQBOVfxBQ62fkpjYz+26u6ZbScxGaVs/QnPxEsqey7GE+u5z5kksOmZy+2Q2LwjmkgRW1isLc9sTqegU+I50XQPaw35sUt8MO+htZeAi4MfrjZcj8xD40HMxP78D/LXPRl2TrEwRHaOA3iNfTwQklDUyNeNsCQtRGfLypMgTzAdxPAEcqaDWDxvizTtbK2EDP8kwTeITV2W4KziFZk4edM1MCzElWDzkM9GOeWa+Vf9T3 matthew@thinkpad" ];
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  networking.interfaces.ens3.ipv6.addresses = [ {
    address = "2a01:4f8:1c1c:d5c3::1";
    prefixLength = 64;
  } ];

  networking.defaultGateway6 = { address = "fe80::1"; interface = "ens3"; };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

