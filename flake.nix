{
  description = "Matthew's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs2205.url = "github:nixos/nixpkgs/nixos-22.05";
    nixinate.url = "github:matthewcroughan/nixinate";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    firefox.url = "github:colemickens/flake-firefox-nightly";
    agenix.url = "github:ryantm/agenix";
    robotnix.url = "github:danielfullmer/robotnix";
    fu.url = "github:numtide/flake-utils";
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "fu";
    };
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent";
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-22.05";
      inputs.nixpkgs-22_05.follows = "nixpkgs2205";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixinate, home-manager, nixpkgs, nixpkgs2205, agenix, nixos-hardware, utils, hercules-ci-agent, simple-nixos-mailserver, impermanence, ... }@inputs: {
    apps = nixinate.nixinate.x86_64-linux self;
    # Declare some local packages be available via self.packages
    packages.x86_64-linux = let pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; }; in {
      qimg = pkgs.callPackage ./pkgs/qimg {};
    };

    robotnixConfigurations = nixpkgs.lib.mapAttrs (n: v: inputs.robotnix.lib.robotnixSystem v) {
      pyxis = import ./hosts/pyxis/default.nix;
      # More phones here ...
      # E.g: bacon = import ./hosts/bacon/default.nix;
    };

    nixosConfigurations = {
      t480 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./hosts/t480/configuration.nix)
          utils.nixosModules.autoGenFromInputs
          home-manager.nixosModules.home-manager
          agenix.nixosModules.age
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = import ./users;
              extraSpecialArgs = { inherit inputs; headless = false; };
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };
      swordfish = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            _module.args = {
               nixinate = {
                 host = "swordfish";
                 sshUser = "deploy";
                 buildOn = "remote";
               };
            };
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = import ./users;
              extraSpecialArgs = { inherit inputs; headless = true; };
            };
          }
          (import ./hosts/swordfish/configuration.nix)
          agenix.nixosModules.age
          hercules-ci-agent.nixosModules.multi-agent-service
        ];
        specialArgs = { inherit inputs; };
      };
      matrix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            _module.args = {
               nixinate = {
                 host = "matrix.defenestrate.it";
                 sshUser = "deploy";
                 buildOn = "local";
               };
            };
          }
          (import ./hosts/matrix/configuration.nix)
          agenix.nixosModules.age
        ];
        specialArgs = { inherit inputs; };
      };
      mail = nixpkgs2205.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            _module.args = {
               nixinate = {
                 host = "mail.croughan.sh";
                 sshUser = "deploy";
                 buildOn = "remote";
               };
            };
          }
          (import ./hosts/mail/configuration.nix)
          simple-nixos-mailserver.nixosModules.mailserver
        ];
        specialArgs = { inherit inputs; };
      };
      doesRouter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
      #    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${nixpkgs}/nixos/modules/profiles/hardened.nix"
          home-manager.nixosModules.home-manager
          impermanence.nixosModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = import ./users;
              extraSpecialArgs = { inherit inputs; headless = true; };
            };
            _module.args = {
               nixinate = {
                 host = "185.135.107.83";
                 sshUser = "deploy";
                 buildOn = "local";
               };
            };
          }
          (import ./hosts/doesRouter/configuration.nix)
        ];
        specialArgs = { inherit inputs; };
      };
      hetznix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            _module.args = {
               nixinate = {
                 host = "hetznix";
                 sshUser = "deploy";
                 # Since hetznix is serving my Android phone updates, it's probably
                 # best if I compile this locally on a system with lots of ram.
                 buildOn = "local";
               };
            };
          }
          (import ./hosts/hetznix/configuration.nix)
          agenix.nixosModules.age
        ];
        specialArgs = { inherit inputs; };
      };
      h1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            _module.args = {
               nixinate = {
                 host = "h1";
                 sshUser = "deploy";
                 buildOn = "remote";
               };
            };
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = import ./users;
              extraSpecialArgs = { inherit inputs; headless = true; };
            };
          }
          (import ./hosts/h1/configuration.nix)
          agenix.nixosModules.age
          hercules-ci-agent.nixosModules.multi-agent-service
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
