{ config, lib, ... }:
{

  nix.allowedUsers = [ "6969" ];
  nix.trustedUsers = [ "6969" ];

  containers.plutonomicon-swordfish = {
    autoStart = true;
    ephemeral = true;
    bindMounts = {
      "/run/secrets" = {
        hostPath = "/run/secrets";
        isReadOnly = true;
      };
      "/nix" = {
        hostPath = "/nix";
        isReadOnly = false;
      };
    };
    config = { config, pkgs, ... }: {
      users.users.hercules-ci-agent.uid = 6969;
      nix = {
        package = pkgs.nixUnstable;
        extraOptions = ''
          experimental-features = nix-command flakes
        '';
       };
      services.hercules-ci-agent = {
        enable = true;
        settings = {
          clusterJoinTokenPath = "/run/secrets/plutonomiconHerculesClusterJoinToken";
          binaryCachesPath = "/run/secrets/plutonomiconHerculesBinaryCaches";
        };
      };
    };
  };

  age.secrets = {
    plutonomiconHerculesClusterJoinToken = {
      file = ../../../secrets/plutonomiconHerculesClusterJoinToken.age;
      group = "6969";
      owner = "6969";
    };
    plutonomiconHerculesBinaryCaches = {
      file = ../../../secrets/plutonomiconHerculesBinaryCaches.age;
      group = "6969";
      owner = "6969";
    };
    platonicHerculesClusterJoinToken = {
      file = ../../../secrets/platonicHerculesClusterJoinToken.age;
      group = "hercules-ci-agent";
      owner = "hercules-ci-agent";
    };
    platonicHerculesBinaryCaches = {
      file = ../../../secrets/platonicHerculesBinaryCaches.age;
      group = "hercules-ci-agent";
      owner = "hercules-ci-agent";
    };
  };

  services.hercules-ci-agent = {
    enable = true;
    settings = {
      clusterJoinTokenPath = config.age.secrets.platonicHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.platonicHerculesBinaryCaches.path;

    };
  };
}
