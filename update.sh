#!/usr/bin/env nix-shell
#!nix-shell -i bash update-shell.nix
set -xe

cd $(dirname $0)

DOMAIN="gitlab.com"
OWNER="soapbox-pub"
REPO="rebased"
#REV="$(curl "https://$DOMAIN/api/v4/projects/$OWNER%2F$REPO/repository/tags" | jq -r '.[0] | .name')"
REV=13c61e59e7e71f7d7dc2cfce5f65904fb118ca21
OUT="$(nix-prefetch-url --unpack --print-path "https://$DOMAIN/api/v4/projects/$OWNER%2F$REPO/repository/archive.tar.gz?sha=$REV")"
HASH="$(echo "$OUT" | head -n1)"
src="$(echo "$OUT" | tail -n1)"

echo "
{ fetchFromGitLab }:

rec {
  version = \"$(echo $REV | sed 's/v//g')\";
  src = fetchFromGitLab {
    domain = \"$DOMAIN\";
    owner = \"$OWNER\";
    repo = \"$REPO\";
    rev = \"$REV\";
    sha256 = \"$HASH\";
  };
}
" > source.nix

tmpdir="$(mktemp -d --suffix "update-pleroma")"
trap "rm -rf ''${tmpdir};" EXIT

rsync -a "$src/" "$tmpdir/"
chmod -R u+rwX "$tmpdir"
(
  cd "$tmpdir" && \
  sed 's/, "[a-f0-9]\{64\}"},/},/' -i mix.lock && \
  mixnix | sed 's/builder/buildTool/' > mix.nix
)
cp $tmpdir/mix.nix .
