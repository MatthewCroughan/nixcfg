self:

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./modules
    ];

  _module.args.inputs = self.inputs;

  home.username = "matthew";
  home.homeDirectory = "/home/matthew";

  programs.home-manager.enable = true;

  xdg.enable = true;

  home.file."scripts".source = "${self}/scripts"; # pass 'self' in order to allow ./users/default.nix -> ./users/matthew/default.nix to access ${self}, to provide a path relative to flake.nix.

#  # Set cursor theme
#  home.file.".icons/default".source = "${pkgs.gnome3.adwaita-icon-theme}/share/icons/Adwaita";
#  xsession.pointerCursor = {
#    package = pkgs.gnome3.adwaita-icon-theme;
#    name = "Adwaita";
#    size = 24;
#  };

  programs.bash = {
    enable = true;
    initExtra = builtins.readFile "${self}/dotfiles/bashrc";
    shellAliases = {
      something = "${pkgs.ffmpeg}/bin/ffmpeg --someoption";
    };
  };

  home = { 
    extraOutputsToInstall = [ "man" ]; # Additionally installs the manpages for each pkg

    packages = with pkgs;
      [
        ## tools
	kitty

        # latest.firefox-nightly-bin
	manpages

        ## misc
      ];
    };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
