{
  overlay = self: super: {
    rnix-lsp_0_2_0 = with super; rustPlatform.buildRustPackage {
      pname = "rnix-lsp-unstable";
      version = "2021-07-05";
      src = fetchFromGitHub {
        owner = "nix-community";
        repo = "rnix-lsp";
        rev = "cbd13a0f9f7c066a545a30c63fcb7e225a069cf3";
        sha256 = "sha256-CwMa2n53+ZzMoCY1c795iyBMO9W9myByYfjfOGEFim0=";
      };
      cargoSha256 = "sha256-uKncKlguo78t5jcP17uE2/Ru2tlEMFcxX0oB8l8pYmI=";
    };
  };
}
