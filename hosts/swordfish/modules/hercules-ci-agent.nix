{ config, lib, inputs, pkgs,  ... }:
{

  services.hercules-ci-agents."tunnelvr-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.tunnelvrHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.tunnelvrHerculesBinaryCaches.path;
    };
  };

  services.hercules-ci-agents."nixifiedai-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.nixifiedAiHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.nixifiedAiHerculesBinaryCaches.path;
      secretsJsonPath = config.age.secrets.nixifiedAiHerculesSecrets.path;
    };
  };

  services.hercules-ci-agents."matthewcroughan-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.matthewcroughanHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.matthewcroughanHerculesBinaryCaches.path;
    };
  };

  services.hercules-ci-agents."nixhow-swordfish" = {
    settings = {
      clusterJoinTokenPath = config.age.secrets.nixhowHerculesClusterJoinToken.path;
      binaryCachesPath = config.age.secrets.nixhowHerculesBinaryCaches.path;
      secretsJsonPath = config.age.secrets.nixhowHerculesSecrets.path;
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
    nixhowHerculesClusterJoinToken = {
      file = ../../../secrets/nixhowHerculesClusterJoinToken.age;
      group = "hci-nixhow-swordfish";
      owner = "hci-nixhow-swordfish";
    };
    nixhowHerculesSecrets = {
      file = ../../../secrets/nixhowHerculesSecrets.age;
      group = "hci-nixhow-swordfish";
      owner = "hci-nixhow-swordfish";
    };
    nixhowHerculesBinaryCaches = {
      file = ../../../secrets/nixhowHerculesBinaryCaches.age;
      group = "hci-nixhow-swordfish";
      owner = "hci-nixhow-swordfish";
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
    nixifiedAiHerculesClusterJoinToken = {
      file = ../../../secrets/nixifiedAiHerculesClusterJoinToken.age;
      group = "hci-nixifiedai-swordfish";
      owner = "hci-nixifiedai-swordfish";
    };
    nixifiedAiHerculesBinaryCaches = {
      file = ../../../secrets/nixifiedAiHerculesBinaryCaches.age;
      group = "hci-nixifiedai-swordfish";
      owner = "hci-nixifiedai-swordfish";
    };
    nixifiedAiHerculesSecrets = {
      file = ../../../secrets/nixifiedAiHerculesSecrets.age;
      group = "hci-nixifiedai-swordfish";
      owner = "hci-nixifiedai-swordfish";
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
