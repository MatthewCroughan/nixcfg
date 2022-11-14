{ pkgs, ... }:

{
  config = {
    home-manager.users.matthew = { pkgs, ... }: {
      programs.mako = {
        enable = true;
        font = "Terminus";
      };
    };
  };
}
