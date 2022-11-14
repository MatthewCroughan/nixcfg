{ config, inputs, ... }:
let
  keys = inputs.self.nixosModules.ssot-keys;
in
{
  nix.settings.trusted-users = [ "matthew" ];
  users.users.matthew = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "dialout"
    ];
    openssh.authorizedKeys.keys = keys.matthew;
  };
}
