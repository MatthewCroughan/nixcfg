{ config, inputs, ... }:
let
  keys = import "${inputs.self}/mixins/ssot/keys.nix";
in
{
  nix.trustedUsers = [ "deploy" ];
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
