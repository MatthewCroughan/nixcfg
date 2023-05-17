{ config, ... }:
{
  services.hercules-ci-agents."matthewcroughan-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.matthewcroughanHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.matthewcroughanHerculesBinaryCaches.path;
    };
  };

  services.hercules-ci-agents."stardustxr-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.stardustXrHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.stardustXrHerculesBinaryCaches.path;
      secretsJsonPath = config.age.secrets.stardustXrHerculesSecrets.path;
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
    stardustXrHerculesClusterJoinToken = {
      file = ../../../secrets/stardustXrHerculesClusterJoinToken.age;
      group = "hci-stardustxr-swordfish";
      owner = "hci-stardustxr-swordfish";
    };
    stardustXrHerculesBinaryCaches = {
      file = ../../../secrets/stardustXrHerculesBinaryCaches.age;
      group = "hci-stardustxr-swordfish";
      owner = "hci-stardustxr-swordfish";
    };
    stardustXrHerculesSecrets = {
      file = ../../../secrets/stardustXrHerculesSecrets.age;
      group = "hci-stardustxr-swordfish";
      owner = "hci-stardustxr-swordfish";
    };
  };
}
