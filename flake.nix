{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    packages.x86_64-linux.rebased = pkgs.callPackage ./default.nix {};
  };
}
