{ config, lib, inputs, pkgs,  ... }:
{

  services.hercules-ci-agents."tunnelvr-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.tunnelvrHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.tunnelvrHerculesBinaryCaches.path;
    };
  };

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
    tunnelvrHerculesClusterJoinToken = {
      file = ../../../secrets/tunnelvrHerculesClusterJoinToken.age;
      group = "hci-tunnelvr-swordfish";
      owner = "hci-tunnelvr-swordfish";
    };
    tunnelvrHerculesBinaryCaches = {
      file = ../../../secrets/tunnelvrHerculesBinaryCaches.age;
      group = "hci-tunnelvr-swordfish";
      owner = "hci-tunnelvr-swordfish";
    };
  };

}
