{
  description = "Matthew's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager";
    firefox.url = "github:colemickens/flake-firefox-nightly";
    firefox.inputs.nixpkgs.follows = "nixpkgs";
  };

#  inputs.neovim-nightly = {
#    type = "github";
#    owner = "mjlbach";
#    repo = "neovim-nightly-overlay";
#    ref = "flakes";
#    flake = true;
#  };

  outputs = { self, home-manager, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      t480 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./hosts/t480/configuration.nix)
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./users self; # pass 'self' in order to allow ./users/default.nix -> ./users/matthew/default.nix to access ${self}, to provide a path relative to flake.nix.
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
