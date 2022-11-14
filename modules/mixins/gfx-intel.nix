# Taken from Colemickens
# https://github.com/colemickens/nixcfg/blob/93e3d13b42e2a0a651ec3fbe26f3b98ddfdd7ab9/mixins/gfx-intel.nix

{ pkgs, lib, config, inputs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      libva-utils
    ];
    hardware = {
      opengl = {
        extraPackages = []
        ++ lib.optionals (pkgs.system=="x86_64-linux") (with pkgs; [
            intel-media-driver
            vaapiIntel
            vaapiVdpau
            libvdpau-va-gl
        ]);
      };
    };
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {
        enableHybridCodec = true;
      };
    };
  };
}
