{ config, lib, inputs, ... }:
{
  imports = [ "${inputs.self}/modules/hydroxide.nix" ];

  services.hydroxide = {
    enable = true;
    host = "0.0.0.0";
  };
}
