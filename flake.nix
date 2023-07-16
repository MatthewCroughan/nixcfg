{
  description = "Matthew's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs2305.url = "github:nixos/nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixinate = {
      url = "github:matthewcroughan/nixinate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox = {
      url = "github:colemickens/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    robotnix.url = "github:danielfullmer/robotnix";
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent";
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-23.05";
      inputs.nixpkgs-23_05.follows = "nixpkgs2305";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    { self
    , nixinate
    , home-manager
    , nixpkgs
    , nixpkgs2305
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
            nixos-hardware.nixosModules.common-gpu-intel
          ];
          specialArgs = { inherit inputs; };
        };
        swordfish = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            utils.nixosModules.autoGenFromInputs
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
        mail = nixpkgs2305.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/mail/configuration.nix
            simple-nixos-mailserver.nixosModules.mailserver
          ];
          specialArgs = { inherit inputs; };
        };
        doesRouter = nixpkgs2305.lib.nixosSystem {
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
            utils.nixosModules.autoGenFromInputs
            home-manager.nixosModules.home-manager
            agenix.nixosModules.age
            hercules-ci-agent.nixosModules.multi-agent-service
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
