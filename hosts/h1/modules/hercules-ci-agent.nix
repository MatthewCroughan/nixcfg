{ config, lib, pkgs,  ... }:
{

  services.hercules-ci-agents."kl-h1" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.klHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.klHerculesBinaryCaches.path;
    };
  };

  age.secrets = {
    klHerculesClusterJoinToken = {
      file = ../../../secrets/klHerculesClusterJoinToken.age;
      group = "hci-kl-h1";
      owner = "hci-kl-h1";
    };
    klHerculesBinaryCaches = {
      file = ../../../secrets/klHerculesBinaryCaches.age;
      group = "hci-kl-h1";
      owner = "hci-kl-h1";
    };
  };

}
