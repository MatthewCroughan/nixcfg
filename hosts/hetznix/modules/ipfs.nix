{
  services = {
    kubo = {
      enable = true;
      defaultMode = "norouting";
      emptyRepo = true;
      settings.Addresses = {
        Gateway = "/ip4/127.0.0.1/tcp/8070";
        API = "/ip4/127.0.0.1/tcp/5001";
      };
    };
  };
}
