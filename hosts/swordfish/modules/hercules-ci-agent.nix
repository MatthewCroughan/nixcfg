{ config, lib, ... }:
{

  nix.allowedUsers = [ "6969" "7979" ];
  nix.trustedUsers = [ "6969" "7979" ];

  containers.tunnelvr-swordfish = {
    autoStart = true;
    ephemeral = true;
    bindMounts = {
      "/run/secrets" = {
        hostPath = "/run/secrets";
        isReadOnly = true;
      };
    };
    config = { config, pkgs, ... }: {
      users.users.hercules-ci-agent.uid = 7979;
      networking.useHostResolvConf = false;
      services.resolved.enable = true;
      nix = {
        package = pkgs.nixUnstable;
        extraOptions = ''
          experimental-features = nix-command flakes
        '';
       };
      services.hercules-ci-agent = {
        enable = true;
        settings = {
          clusterJoinTokenPath = "/run/secrets/tunnelvrHerculesClusterJoinToken";
          binaryCachesPath = "/run/secrets/tunnelvrHerculesBinaryCaches";
        };
      };
    };
  };

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
      networking.useHostResolvConf = false;
      services.resolved.enable = true;
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
    tunnelvrHerculesClusterJoinToken = {
      file = ../../../secrets/tunnelvrHerculesClusterJoinToken.age;
      group = "7979";
      owner = "7979";
    };
    tunnelvrHerculesBinaryCaches = {
      file = ../../../secrets/tunnelvrHerculesBinaryCaches.age;
      group = "7979";
      owner = "7979";
    };
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
