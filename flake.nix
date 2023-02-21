{
  description = "Matthew's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs2211.url = "github:nixos/nixpkgs/nixos-22.11";
    nixinate.url = "github:matthewcroughan/nixinate";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    firefox.url = "github:colemickens/flake-firefox-nightly";
    agenix.url = "github:ryantm/agenix";
    robotnix.url = "github:danielfullmer/robotnix";
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent";
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-22.11";
      inputs.nixpkgs-22_11.follows = "nixpkgs2211";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    { self
    , nixinate
    , home-manager
    , nixpkgs
    , nixpkgs2211
    , agenix
    , nixos-hardware
    , utils
    , hercules-ci-agent
    , simple-nixos-mailserver
    , impermanence
    , robotnix
    , ...
    } @ inputs: {
      apps = nixinate.nixinate.x86_64-linux self;
      nixosModules = import ./modules { lib = nixpkgs.lib; };
      robotnixConfigurations = nixpkgs.lib.mapAttrs (n: v: robotnix.lib.robotnixSystem v) {
        pyxis = import ./hosts/pyxis/default.nix;
        # More phones here ...
        # E.g: bacon = import ./hosts/bacon/default.nix;
      };
      nixosConfigurations = {
        t480 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/t480/configuration.nix
            utils.nixosModules.autoGenFromInputs
            home-manager.nixosModules.home-manager
            agenix.nixosModules.age
            nixos-hardware.nixosModules.lenovo-thinkpad-t480
            nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
          ];
          specialArgs = { inherit inputs; };
        };
        swordfish = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/swordfish/configuration.nix
            home-manager.nixosModules.home-manager
            agenix.nixosModules.age
            hercules-ci-agent.nixosModules.multi-agent-service
          ];
          specialArgs = { inherit inputs; };
        };
        matrix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/matrix/configuration.nix
            agenix.nixosModules.age
          ];
          specialArgs = { inherit inputs; };
        };
        mail = nixpkgs2211.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/mail/configuration.nix
            simple-nixos-mailserver.nixosModules.mailserver
          ];
          specialArgs = { inherit inputs; };
        };
        doesRouter = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/doesRouter/configuration.nix
            "${nixpkgs}/nixos/modules/profiles/hardened.nix"
            home-manager.nixosModules.home-manager
            impermanence.nixosModule
          ];
          specialArgs = { inherit inputs; };
        };
        hetznix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/hetznix/configuration.nix
            agenix.nixosModules.age
          ];
          specialArgs = { inherit inputs; };
        };
        h1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/h1/configuration.nix
            home-manager.nixosModules.home-manager
            agenix.nixosModules.age
            hercules-ci-agent.nixosModules.multi-agent-service
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
