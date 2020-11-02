Instead of `../../scripts` in `home.file."scripts".source`:

```nix
# ./users/matthew/default.nix

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./modules
    ];

  home.username = "matthew";
  home.homeDirectory = "/home/matthew";

  programs.home-manager.enable = true;

  home.file."scripts".source = ../../scripts;
}                      # HERE: ^^^^^^^^^^^^^
```

One can pass `self` to each file that imports `./users/matthew/default.nix` in
order to resolve the path relative to the `flake.nix` at the root of the repo.

First in `flake.nix`

```nix
{
  description = "Matthew's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, home-manager, nixpkgs, ... }: {
    nixosConfigurations = {
      t480 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./hosts/t480/configuration.nix)
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./users self;
          }                             # HERE: ^^^^
        ];
      };
    };
  };
}
```
Then in the first layer of the import  `./users/default.nix`

```nix
# ./users/default.nix
self: # <- explicitly declaring self

{
  matthew = import ./matthew self;
}
```

Then in the next layer of the import  `./users/matthew/default.nix`

```nix
# ./users/matthew/default.nix
self: # <- explicitly declaring self

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./modules
    ];

  home.username = "matthew";
  home.homeDirectory = "/home/matthew";

  programs.home-manager.enable = true;

  home.file."scripts".source = "${self}/scripts";
}                             # ^^^^^^^ <- string interpolating 'self' to reveal relative path from flake.nix at root of repo.
```
