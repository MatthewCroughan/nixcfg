{ stdenv, lib, fetchFromGitHub, linux-pam, git, libxcb, ncurses }:

# This package is was reworked for usage in NixOS, the original author is
# nullgem, not Matthew Croughan.

stdenv.mkDerivation rec {
  name = "ly";

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
    mkdir -p $out/res
    cp bin/ly $out/bin
    cp -r res/* $out/res
  '';

  meta = with lib; {
    description = "TUI display manager";
    license = licenses.wtfpl;
    homepage = "https://github.com/nullgemm/ly";
    maintainers = with maintainers; [ matthewcroughan nixinator ];
  };
}
