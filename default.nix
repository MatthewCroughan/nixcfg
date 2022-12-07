{ lib, callPackage, beamPackages, fetchpatch, git, cmake, file, libxcrypt, writeText, fetchHex, erlang }:

let
  mixnix = callPackage ./mixnix/mix2nix.nix {};

  pc_1_11_0 = beamPackages.buildHex {
    name = "pc";
    version = "1.11.0";
    sha256 = "0s00j4icaikwr1k0bv0dvbpp9nffqxvvppl51mmngkhrdhlbfq5c";
  };

in mixnix.mkPureMixPackage rec {
  name = "pleroma";
  inherit (callPackage ./source.nix {}) src version;

  beamDeps = [];


  postPatch = ''
    sed -E -i 's/(^|\s):os_mon,//' mix.exs
  '';

  # cf. https://github.com/whitfin/cachex/issues/205
  stripDebug = false;

  importedMixNix = let
    deps = lib.filterAttrs (k: v: k != "nodex") (import ./mix.nix);
  in deps // {
    restarter = {
      buildTool = "mix";
      src = src + "/restarter";
      version = "0.1.0";
    };

    p1_utils = beamPackages.buildRebar3 rec {
      name = "p1_utils";
      version = "1.0.18";

      src = fetchHex {
        pkg = name;
        version = "${version}";
        sha256 = "120znzz0yw1994nk6v28zql9plgapqpv51n9g6qm6md1f4x7gj0z";
      };
      beamDeps = [];
      buildTool = "rebar3";
    };

    eimp = beamPackages.buildRebar3 rec {
      name = "eimp";
      version = "1.0.18";

      src = fetchHex {
        pkg = name;
        inherit version;
        sha256 = "0fnx2pm1n2m0zs2skivv43s42hrgpq9i143p9mngw9f3swjqpxvx";
      };

      deps = [ "p1_utils" ];
      buildTool = "rebar3";
    };

    websocket_client = deps.websocket_client // {
      buildTool = "rebar3";
    };

    crypt = deps.crypt // {
      buildTool = "rebar3";
    };
    eblurhash = deps.eblurhash // {
      buildTool = "rebar3";
    };
    prometheus_phx = deps.prometheus_phx // {
      deps = [ "prometheus_ex" ];
    };
    prometheus_ex = deps.prometheus_ex // {
      fetchGit = deps.prometheus_ex.fetchGit // {
        allRefs = true;
      };
    };
    gettext = deps.gettext // {
      fetchGit = deps.gettext.fetchGit // {
        allRefs = true;
      };
    };
  };

  mixConfig = {
    fast_html = { ... }: {
      nativeBuildInputs = [ cmake ];
    };
    syslog = { ... }: {
      patches = [ ./syslog.patch ];
      buildPlugins = [ pc_1_11_0 ];
    };
    crypt = {version, ...}: {
      buildInputs = [ libxcrypt ];
      postInstall = "mv $out/lib/erlang/lib/crypt-${version}/priv/{source,crypt}.so";
    };
    majic = { ... }: {
      #patchPhase = ''
      #  sed 's/erlang.now/erlang.time/g' -i lib/majic/server.ex
      #'';
      buildInputs = [ file ];
    };

    http_signatures = { ... }: {
      patchPhase = ''
        sed 's/:logger/&, :public_key/' -i mix.exs
      '';
    };

    eimp = { ... }: {
      buildPlugins = [ pc_1_11_0 ];
      buildInputs = [ erlang ];
      patchPhase = ''
        echo '{plugins, [pc]}.' >> rebar.config
      '';
    };

    mime = { ... }: {
      patchPhase = let
        cfgFile = writeText "config.exs" ''
          use Mix.Config
          config :mime, :types, %{
            "application/activity+json" => ["activity+json"],
            "application/jrd+json" => ["jrd+json"],
            "application/ld+json" => ["activity+json"],
            "application/xml" => ["xml"],
            "application/xrd+xml" => ["xrd+xml"]
          }
        '';
      in ''
        mkdir config
        cp ${cfgFile} config/config.exs
      '';
    };

    captcha = { name, version, ... }: {
      postInstall = "mv priv/* $out/lib/erlang/lib/${name}-${version}/priv/";
    };

  };

  buildInputs = [ git ];
  preBuild = "echo 'import Mix.Config' > config/prod.secret.exs";
  postBuild = "mix release --path $out --no-deps-check";
}
