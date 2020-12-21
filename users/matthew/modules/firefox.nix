{ config, pkgs, inputs, ... }:

let
  firefoxFlake = inputs.firefox.packages.${pkgs.system};
in
{
  programs.firefox = {
    enable = true;
    package = firefoxFlake.firefox-nightly-bin;
  };
}
