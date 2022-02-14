{
  description = "Matthew's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    nur.url = "github:nix-community/NUR";
    nixinate.url = "github:matthewcroughan/nixinate";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    firefox.url = "github:colemickens/flake-firefox-nightly";
    firefox.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    robotnix.url = "github:danielfullmer/robotnix";
    flake-ndi.url = "github:matthewcroughan/flake-ndi";
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
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent/stopgap-multi-agent-module";
  };

  outputs = { self, nixinate, home-manager, nixpkgs, agenix, nixos-hardware, utils, hercules-ci-agent, ... }@inputs: {
    apps = nixinate.nixinate.x86_64-linux self;
    # Declare some local packages be available via self.packages
    packages.x86_64-linux = let pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; }; in {
      parsecgaming = pkgs.callPackage ./pkgs/parsecgaming {};
      dolphin-emu = pkgs.dolphinEmuMaster.overrideAttrs (old: { src = inputs.dolphin-emu; version = inputs.dolphin-emu.rev; cmakeFlags = old.cmakeFlags ++ [ "-DDOLPHIN_WC_REVISION=${inputs.dolphin-emu.rev}" "-DDOLPHIN_WC_DESCRIBE=${pkgs.lib.substring 0 8 inputs.dolphin-emu.rev}" ]; });
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
            _module.args = {
               nixinate = {
                 host = "t480";
                 sshUser = "matthew";
               };
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./users self; # pass 'self' in order to allow ./users/default.nix -> ./users/matthew/default.nix to access ${self}, to provide a path relative to flake.nix.
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
                 sshUser = "matthew";
               };
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./users self; # pass 'self' in order to allow ./users/default.nix -> ./users/matthew/default.nix to access ${self}, to provide a path relative to flake.nix.
          }
          (import ./hosts/swordfish/configuration.nix)
          agenix.nixosModules.age
          hercules-ci-agent.nixosModules.stop-gap-multi-agent-service
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
                 sshUser = "matthew";
               };
            };
          }
          (import ./hosts/matrix/configuration.nix)
          agenix.nixosModules.age
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
