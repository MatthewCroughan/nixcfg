{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    relative.url = "github:tomberek/relative";
  };
  outputs = { self, nixpkgs, relative }:
    let
      one = (import ./subflake/flake.nix).outputs { nixpkgs = nixpkgs; self.outPath = "${./subflake}"; };
      two = relative.lib.callLocklessFlake ./subflake { nixpkgs = nixpkgs; };
    in
    {
      x = one.subflakeOutputs // { outPath = self.outPath; };
      y = two.subflakeOutputs;
    };
}
