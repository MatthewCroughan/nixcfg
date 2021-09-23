{
  overlay = self: super: {
    rnix-lsp_0_2_0 = with super; rustPlatform.buildRustPackage {
      pname = "rnix-lsp-unstable";
      version = "2021-07-05";
      src = fetchFromGitHub {
        owner = "nix-community";
        repo = "rnix-lsp";
        rev = "b940e4b6d3f1e4be014e076a0a59e69b35c67ba5";
        sha256 = "sha256-GhKZG6IxlTKkynggMstm/L1oUVRZa5ZWh1P3UUZtT6g=";
      };
      cargoSha256 = "sha256-uKncKlguo78t5jcP17uE2/Ru2tlEMFcxX0oB8l8pYmI=";
    };
  };
}
