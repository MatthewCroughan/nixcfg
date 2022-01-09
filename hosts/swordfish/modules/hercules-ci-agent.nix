{ config, lib, ... }:
{

  services.hercules-ci-agents."tunnelvr-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.tunnelvrHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.tunnelvrHerculesBinaryCaches.path;
    };
  };

  services.hercules-ci-agents."plutonomicon-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.plutonomiconHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.plutonomiconHerculesBinaryCaches.path;
      secretsJsonPath = config.age.secrets.plutonomiconHerculesSecrets.path;
    };
  };

  services.hercules-ci-agents."ardana-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.ardanaHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.ardanaHerculesBinaryCaches.path;
    };
  };

  age.secrets = {
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
    plutonomiconHerculesBinaryCaches = {
      file = ../../../secrets/plutonomiconHerculesBinaryCaches.age;
      group = "hci-plutonomicon-swordfish";
      owner = "hci-plutonomicon-swordfish";
    };
    plutonomiconHerculesClusterJoinToken = {
      file = ../../../secrets/plutonomiconHerculesClusterJoinToken.age;
      group = "hci-plutonomicon-swordfish";
      owner = "hci-plutonomicon-swordfish";
    };
    plutonomiconHerculesSecrets = {
      file = ../../../secrets/plutonomiconHerculesSecrets.age;
      group = "hci-plutonomicon-swordfish";
      owner = "hci-plutonomicon-swordfish";
    };
    ardanaHerculesClusterJoinToken = {
      file = ../../../secrets/ardanaHerculesClusterJoinToken.age;
      group = "hci-ardana-swordfish";
      owner = "hci-ardana-swordfish";
    };
    ardanaHerculesBinaryCaches = {
      file = ../../../secrets/ardanaHerculesBinaryCaches.age;
      group = "hci-ardana-swordfish";
      owner = "hci-ardana-swordfish";
    };
  };

}
