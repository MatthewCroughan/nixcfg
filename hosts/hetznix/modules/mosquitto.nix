{
  networking.firewall.allowedTCPPorts = [ 1883 8080 ];
  services.mosquitto = {
    enable = true;
    settings.max_keepalive = 300;
    listeners = [
      {
        port = 1883;
        omitPasswordAuth = true;
        users = {};
        settings = {
          allow_anonymous = true;
        };
        acl = [ "topic readwrite #" ];
      }
      {
        port = 8080;
        omitPasswordAuth = true;
        users = {};
        settings = {
          protocol = "websockets";
          allow_anonymous = true;
        };
        acl = [ "topic readwrite #" "pattern readwrite #" ];
      }
    ];
  };
}
