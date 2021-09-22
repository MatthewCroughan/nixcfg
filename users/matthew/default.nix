#self:
#  _module.args.inputs = self.inputs;

# Now, I bring `self` into scope like this instead.

{ config, lib, pkgs, inputs, self, ... }:

{
  imports =
    [
      ./modules
    ];

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
    bashrcExtra = ''
      export EDITOR=vim
      
      mach-shell() {
        pypiApps=$(for arg; do printf '.%s' "$arg"; done) 
        nix shell github:davhau/mach-nix#gen.pythonWith$pypiApps
      }

      # Prints a list of webm urls for a given 4chan thread link
      getwebm() { 
        ${pkgs.curl}/bin/curl -sL "$1.json" | ${pkgs.jq}/bin/jq -r '.posts[] | select(.ext == ".webm") | "https://i.4cdn.org/'"$(echo "$1" | sed -r 's/.*(4chan|4channel).org\/([a-zA-Z0-9]+)\/.*/\2/')"'/\(.tim)\(.ext)"';
      }

      # Makes `nix inate` as an alias of `nix shell`.
      nix() {
        case $1 in
          inate)
            shift
            command nix shell "$@"
            ;;
          *)
            command nix "$@";;
        esac
      }
    '';
    shellAliases = {
      something = "${pkgs.ffmpeg}/bin/ffmpeg --someoption";
      n = "nix-shell -p";
      r = "nix repl ${inputs.utils.lib.repl}";
      ssh = "env TERM=xterm-256color ssh";
      ipv6off = "sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1 -w net.ipv6.conf.default.disable_ipv6=1 -w net.ipv6.conf.lo.disable_ipv6=1";
      ipv6on = "sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0 -w net.ipv6.conf.default.disable_ipv6=0 -w net.ipv6.conf.lo.disable_ipv6=0";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      username = {
        format = "user: [$user]($style) ";
        show_always = true;
      };
      shlvl = {
        disabled = false;
        format = "$shlvl ▼ ";
        threshold = 4;
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    theme.package = pkgs.arc-theme;
    theme.name = "Arc-Dark";
    iconTheme.package = pkgs.arc-icon-theme;
    iconTheme.name = "Arc";
  };

  home = { 
    extraOutputsToInstall = [ "man" ]; # Additionally installs the manpages for each pkg


    packages = with pkgs;
      [
        ## tools
        self.packages.x86_64-linux.parsecgaming
        self.packages.x86_64-linux.dolphin-emu
        quasselClient

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
