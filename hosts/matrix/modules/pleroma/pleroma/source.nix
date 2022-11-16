
{ fetchFromGitLab }:

rec {
  version = "f40ccce7e9ad2e9f917fddd798138866c83e514a";
  src = fetchFromGitLab {
    domain = "git.pleroma.social";
    owner = "pleroma";
    repo = "pleroma";
    rev = "f40ccce7e9ad2e9f917fddd798138866c83e514a";
    sha256 = "0fli5aqhljrvz2b72dikgllh4wzp6p0kscj748qh0llh31n0vcjc";
  };
}

