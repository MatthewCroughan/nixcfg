{ stdenv, lib, fetchFromGitHub, linux-pam, git, libxcb, ncurses }:

# This package is intended to be reworked, it is temporarily using a fork since
# the original developer used a non-standard method of specifying .gitmodules.
# https://github.com/nullgemm/ly/pull/279

stdenv.mkDerivation rec {
  name = "ly";

#  hardeningDisable = [ "all" ];

  nativeBuildInputs = [ git ];

  buildInputs = [ libxcb linux-pam ncurses ];

  propogatedBuildInputs = [ ncurses ];

  src = fetchFromGitHub {
    owner = "matthewcroughan";
    repo = "ly";
    rev = "695a3c21e6cb603a0b4a7041ff872bd2d8402208";
    sha256 = "sha256-c5BQ/zhVXNvMCPBUTU5YEbb+gI7i4eobI9QaUOoSz9M=";
    fetchSubmodules = true;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp bin/ly $out/bin
  '';

  meta = with lib; {
    description = "TUI display manager";
    license = licenses.wtfpl;
    homepage = "https://github.com/nullgemm/ly";
    maintainers = with maintainers; [ matthewcroughan nixinator ];
  };
}
