{stdenv, curl, cacert}:

{name, version, url, sha256}:

stdenv.mkDerivation {
  name = "hex-archive-${name}-${version}";
  builder = ./builder.sh;
  nativeBuildInputs = [ curl cacert ];

  impureEnvVars = [ "http_proxy" ];

  outputHashAlgo = "sha256";
  outputHashMode = "flat";
  outputHash = sha256;

  inherit url;
  preferLocalBuild = true;
}
