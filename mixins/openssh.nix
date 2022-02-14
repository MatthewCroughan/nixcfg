{ lib, ... }:
{
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    openFirewall = lib.mkForce true;
    permitRootLogin = lib.mkForce "no";
  };
}
