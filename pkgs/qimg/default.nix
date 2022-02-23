{ writeShellApplication
, stdenv
, wl-clipboard
, xclip
}:
writeShellApplication {
  name = "qimg";
  checkPhase = "";
  runtimeInputs = [ wl-clipboard xclip stdenv ];
  text = (builtins.readFile ./qimg.sh);
}
