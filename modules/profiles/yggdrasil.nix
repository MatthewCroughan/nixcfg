{
  services.yggdrasil = {
    enable = true;
    openMulticastPort = true;
    persistentKeys = true;
    settings = {
      "Peers" = [
        "tls://ygg.yt:443"
      ];
      "MulticastInterfaces" = [
        {
          "Regex" = "w.*";
          "Beacon" = true;
          "Listen" = true;
          "Port" = 9001;
          "Priority" = 0;
        }
      ];
      "AllowedPublicKeys" = [];
      "IfName" = "auto";
      "IfMTU" = 65535;
      "NodeInfoPrivacy" = false;
      "NodeInfo" = null;
    };
  };
}
