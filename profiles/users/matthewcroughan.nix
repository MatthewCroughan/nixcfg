{ config, inputs, ... }:
let
  keys = import "${inputs.self}/mixins/ssot/keys.nix";
in
{
  nix.trustedUsers = [ "matthew" ];
  users.users.matthew = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "dialout"
    ];
    openssh.authorizedKeys.keys = keys.matthew;
  };
}
