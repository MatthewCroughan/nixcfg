{
  services.tor = {
    client.dns.enable = false;
    client.enable = true;
    enable = true;
#    relay.onionServices = {
#      ssh.map = [ 22 ];
#    };
  };
}
