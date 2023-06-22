{ config, ... }:
let
  pkgs = import (builtins.getFlake "github:nixos/nixpkgs/d4a9ff82fc18723219b60c66fb2ccb0734c460eb") { system = "x86_64-linux"; };
  source = pkgs.fetchFromGitHub {
    owner = "MatthewCroughan";
    repo = "TediCross";
    rev = "6e12a704f4d2675cd173730f94da7acd9f118841";
    sha256 = "sha256-K1cUILhjZC0YOsJQISV+VPGhaBGfEyiixjAGSHux2HA=";
  };
  tedicross = ((builtins.getFlake "github:nix-community/dream2nix/7005441ceb1be4d850de453a49dde5ca9c575c6e").lib.makeFlakeOutputs {
    systems = [ "${pkgs.hostPlatform.system}" ];
    config.projectRoot = ./.;
    source = source;
  }).packages.${pkgs.hostPlatform.system}.tedicross.overrideAttrs (_: {
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postInstall = ''
      makeWrapper '${pkgs.nodejs-16_x}/bin/node' "$out/bin/tedicross" \
        --add-flags "$out/lib/node_modules/tedicross/dist/main.js"
    '';
  });
  dataDir = "/var/lib/tedicross";
  configFile = config.age.secrets.masariBotsSecrets.path;
in
{
  containers.tedicross = {
    bindMounts = { "${configFile}" = { hostPath = "${configFile}"; isReadOnly = true; }; };
    extraFlags = [ "-U" "--load-credential=secret:${configFile}" ];
    autoStart = true;
    ephemeral = true;
    config = { ... }: {
      systemd.services.tedicross = {
        description = "TediCross Telegram-Discord bridge service";
        wantedBy = [ "multi-user.target" ];
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${tedicross}/bin/tedicross --config=\${CREDENTIALS_DIRECTORY}/secret --data-dir='${dataDir}'";
          Restart = "always";
          DynamicUser = true;
          StateDirectory = baseNameOf dataDir;
          LoadCredential = [ "secret" ]; # Usually this is secret:/the/path, but
                                         # because extraFlags uses
                                         # --load-credential, we're able to
                                         # propagate the secret, by name, from
                                         # the host https://www.freedesktop.org/software/systemd/man/systemd-nspawn.html
        };
      };
    };
  };
  age.secrets = {
    masariBotsSecrets = {
      file = ../../../secrets/masariBotsSecrets.age;
    };
  };
}
