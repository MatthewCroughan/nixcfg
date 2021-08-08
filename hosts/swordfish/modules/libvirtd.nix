{ pkgs, lib, config,  ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuRunAsRoot = false;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  # Add any users in the 'wheel' group to the 'libvirt' group.
  users.groups.libvirt.members = builtins.filter (x: builtins.elem "wheel" config.users.users."${x}".extraGroups) (builtins.attrNames config.users.users);
}
