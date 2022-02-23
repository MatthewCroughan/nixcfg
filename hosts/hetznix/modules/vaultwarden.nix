{
  services.vaultwarden = {
    enable = true;
    config = {
      domain = "https://vaultwarden.croughan.sh";
      signupsAllowed = true;
      rocketPort = 8222;
      rocketAddress = "127.0.0.1";
      rocketLog = "critical";
      disableIconDownload = true;
    };
  };
}
