with import <nixpkgs> {};

let
  mix2nix = callPackage (fetchGit {
    url = "https://gitlab.com/azazel/mixnix/";
    rev = "86b7b717bad345f70b2dcdfe17d34eb582a84d05";
  }) {
    inherit pkgs;
  };
in stdenv.mkDerivation {
  name = "shell";
  buildInputs = [ nix-prefetch-scripts rsync mix2nix nix jq ];
}
