
{ fetchFromGitLab }:

rec {
  version = "2eaa1976ceeb971a6c09354b94875463375d8de5";
  src = fetchFromGitLab {
    domain = "gitlab.com";
    owner = "soapbox-pub";
    repo = "rebased";
    rev = "2eaa1976ceeb971a6c09354b94875463375d8de5";
    sha256 = "150zlagyyw8wam6hisdr3sv7d6y0j9180dickpf56y2klv1y541q";
  };
}

