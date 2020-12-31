{ config, pkgs, self, inputs, ... }:

let
  firefoxFlake = inputs.firefox.packages.${pkgs.system};
in
{
  programs.firefox = with pkgs; {
    enable = true;
    package = firefoxFlake.firefox-nightly-bin;
     # I could install extensions like this, but because Firefox has complex
     # runtime behaviour, the home-manager module doesn't auto-enable these
     # extensions, making it useless compared to just having a sync-server.
#    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
#      https-everywhere
#    ];
  };
}
