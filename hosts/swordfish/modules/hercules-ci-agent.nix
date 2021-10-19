{ config, lib, ... }:
{

  age.secrets = {
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
