{ config, pkgs, self, inputs, ... }:

let
  firefoxFlake = inputs.firefox.packages.${pkgs.system};
in
{
  programs.firefox = with pkgs; {
    enable = true;
    package = firefoxFlake.firefox-nightly-bin;
  };
}
