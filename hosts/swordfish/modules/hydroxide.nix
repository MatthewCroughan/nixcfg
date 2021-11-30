{ config, lib, pkgs, inputs, ... }:
let
  hydroxideOverride = pkgs.buildGoModule rec {
    pname = "hydroxide";
    version = "0.2.21";
    vendorSha256 = "sha256-M5QlhF2Cj1jn5NNiKj1Roh9+sNCWxQEb4vbtsDfapWY=";
    GO111MODULE="on";
    src = pkgs.fetchFromGitHub {
      owner = "emersion";
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-fF+pQnqAWBktc4NdQFTHeB/sEg5bPTxXtdL1x5JuXU8=";
    };
  };
in
{
  imports = [ "${inputs.self}/modules/hydroxide.nix" ];

  services.hydroxide = {
    enable = true;
    host = "0.0.0.0";
    package = hydroxideOverride;
  };
}
