{ config, lib, pkgs, inputs, headless, ... }:

{
  # If we aren't headless, then load ./desktop.nix
  # TODO: This is janky and leads to infinite recursion errors if headless is
  # unset. It's an antipattern, but it's what I can do for now without a big
  # refactor.
  # https://discourse.nixos.org/t/conditionally-import-module-if-it-exists/17832/2
  # https://github.com/jonringer/nixpkgs-config/blob/cc2958b5e0c8147849c66b40b55bf27ff70c96de/flake.nix#L47-L82
  imports = [ ] ++ lib.optional (!headless) ./desktop.nix;

  home = {
    username = "matthew";
    homeDirectory = "/home/matthew";
  };

  programs = {
    starship = {
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
    bash = {
      enable = true;
      bashrcExtra = ''
        print-nuke() {
          echo "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19fXyAgICAgICAgICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgICAgIF9fLC1+fi9+ICAgIGAtLS0uICAgICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgICBfL18sLS0tKCAgICAgICwgICAgKSAgICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgIF9fIC8gICAgICAgIDwgICAgLyAgICkgIFxfX18gICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgPT09PS0tLS0tLS0tLS0tLS0tLS0tLT09PTs7Oz09ICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgIFwvICB+In4ifiJ+In4iflx+In4pfiIsMS8gICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgIChfICggICBcICAoICAgICA+ICAgIFwpICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgICBcXyggXyA8ICAgICAgICAgPl8+JyAgICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgICAgICB+IGAtaScgOjo+fC0tIiAgICAgICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgICAgICAgICAgSTt8LnwufCAgICAgICAgICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgICAgICAgICA8fGk6OnxpfD4gICAgICAgICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgICAgICAgICAgfFs6OnwufCAgICAgICAgICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHx8OiB8ICAgICAgICAgICAgICAgICAgICAgICAK
          ICAgICAgICAgICAgICAgICAgICAgICAgICAgQllFLUJZRQo=" | base64 -d
        }

        flash-to(){
          if [ $(${pkgs.file}/bin/file $1 --mime-type -b) == "application/zstd" ]; then
            echo "Flashing zst using zstdcat | dd"
            ${pkgs.zstd}/bin/zstdcat $1 | sudo dd of=$2 status=progress conv=sync,noerror bs=64k
          elif [ $(${pkgs.file}/bin/file $2 --mime-type -b) == "application/xz" ]; then
            echo "Flashing xz using xzcat | dd"
            ${pkgs.xz}/bin/xzcat $1 | sudo dd of=$2 status=progress conv=sync,noerror bs=64k
          else
            echo "Flashing arbitrary file $1 to $2"
            sudo dd if=$1 of=$2 status=progress conv=sync,noerror bs=64k
          fi
        }

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
  };

  xdg.enable = true;

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
