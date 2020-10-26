{ config, pkgs, lib, inputs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 51820 ]; # Clients and peers can use the same port, see listenport
  };
  environment.systemPackages = [ pkgs.tailscale ];
  services.tailscale.enable = true;
}
