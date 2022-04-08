{
  outputs = { self, nixpkgs }: {
    subflakeOutputs = nixpkgs.legacyPackages.x86_64-linux.hello;
  };
}
