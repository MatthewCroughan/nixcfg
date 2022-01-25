{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    cardano-node.url = "github:input-output-hk/cardano-node/1.33.1";
  };
  outputs = { self, nixpkgs, cardano-node }: {
    nixosConfigurations.cardano-node = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        cardano-node.nixosModules.cardano-node
        {
          networking = {
            hostName = "cardano-node";
            firewall.allowedTCPPorts = [ 3001 ];
          };
          services.cardano-node = {
            enable = true;
            hostAddr = "0.0.0.0";
          };
          imports = [ "${nixpkgs}/nixos/modules/virtualisation/openstack-config.nix" ]; 
          nix = {
            package = nixpkgs.legacyPackages.${system}.pkgs.nixUnstable;
            extraOptions = ''
              experimental-features = nix-command flakes
            '';
            binaryCachePublicKeys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
              "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
            ];
            trustedBinaryCaches = [
              "https://cache.nixos.org"
              "https://hydra.iohk.io" 
              "https://iohk.cachix.org" 
            ];
            binaryCaches = [
              "https://cache.nixos.org"
              "https://hydra.iohk.io" 
              "https://iohk.cachix.org" 
            ];
           };
        }
      ];
    };
  };
}
