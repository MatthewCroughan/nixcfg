{
  systemd.user.services.kanshi = {
    serviceConfig = {
      StartLimitBurst = 5;
      StartLimitIntervalSec = 30;
    };
  };
  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1080";
            position = "0,0";
          }
        ];
      };
      docked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL P2314H J8J3148JAY2B";
            mode = "1920x1080";
            position = "0,240";
          }
          {
            criteria = "Dell Inc. DELL P2314H J8J31455CHGL";
            mode = "1920x1080";
            position = "1920,0";
            transform = "90";
          }
        ];
      };
    };
  };
}
