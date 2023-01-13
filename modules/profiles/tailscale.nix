{ config, lib, ...}:
{
  # This happens to fix a problem with the systemd service that is created as a
  # result of enabling networkd. It's not clear why it happens, but I should
  # re-evaluate whether this is necessary to set in the future.
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
  networking = {
    useNetworkd = true;
    firewall = {
      # trace: warning: Strict reverse path filtering breaks Tailscale exit node
      # use and some subnet routing setups. Consider setting
      # `networking.firewall.checkReversePath` = 'loose'
      checkReversePath = "loose";
      trustedInterfaces = [ "tailscale0" ];
    };
  };
  services = {
    tailscale.enable = true;
    resolved = {
      enable = true;
      dnssec = "false";
    };
  };
}
