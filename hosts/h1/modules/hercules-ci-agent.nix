{ config, ... }:
{
  services.hercules-ci-agents."matthewcroughan-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.matthewcroughanHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.matthewcroughanHerculesBinaryCaches.path;
    };
  };

  age.secrets = {
    matthewcroughanHerculesClusterJoinToken = {
      file = ../../../secrets/matthewcroughanHerculesClusterJoinToken.age;
      group = "hci-matthewcroughan-swordfish";
      owner = "hci-matthewcroughan-swordfish";
    };
    matthewcroughanHerculesBinaryCaches = {
      file = ../../../secrets/matthewcroughanHerculesBinaryCaches.age;
      group = "hci-matthewcroughan-swordfish";
      owner = "hci-matthewcroughan-swordfish";
    };
  };
}
