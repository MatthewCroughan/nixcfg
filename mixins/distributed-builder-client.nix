{ config, inputs, lib, ... }:
{
  programs.ssh.knownHosts."h1" = {
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC4sGuJY4BQ84vcUOr947uhPa/GMEm9VUapGO6TMqQal";
  };
  age = {
    sshKeyPaths = [ "/etc/ssh/ssh_host_rsa_key" "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      distributedBuilderKey = {
        file = "${inputs.self}/secrets/distributedBuilderKey.age";
      };
    };
  };
  nix = {
    buildMachines = [{
      hostName = "h1";
      sshUser = "ssh-ng://nix-ssh";
      sshKey = config.age.secrets.distributedBuilderKey.path;
      system = "x86_64-linux";
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [];
    }];
    distributedBuilds = true;
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
