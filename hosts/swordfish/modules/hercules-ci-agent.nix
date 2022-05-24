{ config, lib, ... }:
{

  services.hercules-ci-agents."orbis-tertius-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.orbis-tertiusHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.orbis-tertiusHerculesBinaryCaches.path;
      secretsJsonPath = config.age.secrets.orbis-tertiusHerculesSecrets.path;
    };
  };

  services.hercules-ci-agents."tunnelvr-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.tunnelvrHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.tunnelvrHerculesBinaryCaches.path;
    };
  };

  services.hercules-ci-agents."ardana-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.ardanaHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.ardanaHerculesBinaryCaches.path;
      secretsJsonPath = config.age.secrets.ardanaHerculesSecrets.path;
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
    orbis-tertiusHerculesBinaryCaches = {
      file = ../../../secrets/orbis-tertiusHerculesBinaryCaches.age;
      group = "hci-orbis-tertius-swordfish";
      owner = "hci-orbis-tertius-swordfish";
    };
    orbis-tertiusHerculesClusterJoinToken = {
      file = ../../../secrets/orbis-tertiusHerculesClusterJoinToken.age;
      group = "hci-orbis-tertius-swordfish";
      owner = "hci-orbis-tertius-swordfish";
    };
    orbis-tertiusHerculesSecrets = {
      file = ../../../secrets/orbis-tertiusHerculesSecrets.age;
      group = "hci-orbis-tertius-swordfish";
      owner = "hci-orbis-tertius-swordfish";
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
    ardanaHerculesSecrets = {
      file = ../../../secrets/ardanaHerculesSecrets.age;
      group = "hci-ardana-swordfish";
      owner = "hci-ardana-swordfish";
    };
  };

}
