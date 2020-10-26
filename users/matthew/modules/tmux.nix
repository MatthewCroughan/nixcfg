{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    terminal = "screen-256color";
    sensibleOnTop = false;
    secureSocket = false;
  };
}
