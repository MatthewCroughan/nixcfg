{
  description = "Matthew's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs2111.url = "github:nixos/nixpkgs/nixos-21.11";
    nixinate.url = "github:matthewcroughan/nixinate";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    firefox.url = "github:colemickens/flake-firefox-nightly";
    agenix.url = "github:ryantm/agenix";
    robotnix.url = "github:danielfullmer/robotnix";
    dolphin-emu = {
      url = "https://github.com/dolphin-emu/dolphin.git";
      type = "git";
      submodules = true;
      flake = false;
    };
    fu.url = "github:numtide/flake-utils";
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "fu";
    };
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent/hercules-ci-agent-0.9.5";
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-21.11";
  };

  outputs = { self, nixinate, home-manager, nixpkgs, nixpkgs2111, agenix, nixos-hardware, utils, hercules-ci-agent, simple-nixos-mailserver, ... }@inputs: {
    apps = nixinate.nixinate.x86_64-linux self;
    # Declare some local packages be available via self.packages
    packages.x86_64-linux = let pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; }; in {
      parsecgaming = pkgs.callPackage ./pkgs/parsecgaming {};
      dolphin-emu = pkgs.dolphinEmuMaster.overrideAttrs (old: { src = inputs.dolphin-emu; version = inputs.dolphin-emu.rev; cmakeFlags = old.cmakeFlags ++ [ "-DDOLPHIN_WC_REVISION=${inputs.dolphin-emu.rev}" "-DDOLPHIN_WC_DESCRIBE=${pkgs.lib.substring 0 8 inputs.dolphin-emu.rev}" ]; });
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
                 buildOn = "remote";
               };
            };
          }
          (import ./hosts/matrix/configuration.nix)
          agenix.nixosModules.age
        ];
        specialArgs = { inherit inputs; };
      };
      mail = nixpkgs2111.lib.nixosSystem {
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
      hetznix = nixpkgs2111.lib.nixosSystem {
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
    };
  };
}
