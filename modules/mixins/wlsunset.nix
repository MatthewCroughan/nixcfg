{ pkgs, ... }:

{
  config = {
    home-manager.users.matthew = { pkgs, ... }: {
      services.wlsunset = {
        enable = true;
        latitude = "53.1453306";
        longitude = "-4.1182089";
        temperature.day = 6500;
        temperature.night = 4500;
      };
    };
  };
}
