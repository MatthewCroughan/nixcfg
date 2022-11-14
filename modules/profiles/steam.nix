{ pkgs, lib, config, inputs, ... }:

{
  config = {
    programs.steam.enable = true;
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = (pkgs.system=="x86_64-linux");
      };
    };
  };
}
