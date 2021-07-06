# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "zroot/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "zroot/root/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zroot/root/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1852ecca-c377-4c6e-b9ff-9fb5a299c233";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/1852ecca-c377-4c6e-b9ff-9fb5a299c233";
      fsType = "ext4";
    };

  fileSystems."/eggshells" =
    { device = "eggshells";
      fsType = "zfs";
    };

  fileSystems."/eggshells/archive" =
    { device = "eggshells/archive";
      fsType = "zfs";
    };

  fileSystems."/eggshells/pve" =
    { device = "eggshells/pve";
      fsType = "zfs";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 2;
  nix.buildCores = 0;

}