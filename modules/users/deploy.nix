{ config, inputs, ... }:
let
  keys = inputs.self.nixosModules.ssot-keys;
in
{
  nix.settings.trusted-users = [ "deploy" ];
  security.sudo.extraRules = [{
    users = [ "deploy" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];
  users = {
    users = {
      deploy = {
        isNormalUser = true;
        openssh.authorizedKeys.keys = keys.matthew;
      };
    };
  };
}
