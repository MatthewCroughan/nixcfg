source $stdenv/setup
echo "Fetching package from $url [$version] into $out"

curl -L "$url" > tmp.tar
tar xf tmp.tar
cat VERSION metadata.config contents.tar.gz > $out
