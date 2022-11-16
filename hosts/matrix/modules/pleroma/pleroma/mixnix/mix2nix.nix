{ stdenv, lib, callPackage, writeText, glibcLocales, beam }:
let
  inherit (builtins) any mapAttrs attrNames attrValues all filterSource trace;
  inherit (lib) filterAttrs optionals optionalString optionalAttrs;
  p = value: lib.traceSeqN 2 value value;

  fetchLockedHex = callPackage ./fetchhex {};

  fixHex = { name, version, ...}@args:
    stdenv.mkDerivation {
      name = "${name}-hex-source";
      version = version;
      src = fetchLockedHex ({ url = "https://repo.hex.pm/tarballs/${name}-${version}.tar"; } // args);

      phases = [ "unpackPhase" "installPhase" ];

      unpackPhase = ''
        # Find offset of the magic pattern for a .tar.gz from the concatenated src
        offset=$(LC_ALL=C grep -obUaP '\x1f\x8b\x08' $src | head -1 | cut -d: -f1)
        dd bs=$offset skip=1 if=$src of=contents.tar.gz
        tar -xzf contents.tar.gz
        rm contents.tar.gz
      '';

      installPhase = ''
        runHook preInstall
        mkdir "$out"
        cp -Hrt "$out" .
        success=1
        runHook postInstall
      '';
    };

  rewriteRebarConfig = builtins.toFile "rewrite-rebar-config.exs" ''
    case :file.consult("rebar.config") do
      {:ok, rebar_config} ->
        terms = rebar_config
              |> List.keyreplace(:deps,    0, {:deps,    []})
              # |> List.keyreplace(:plugins, 0, {:plugins, []})
              # |> List.keyreplace(:provider_hooks, 0, {:provider_hooks, []})
              # |> List.keyreplace(:artifacts, 0, {:artifacts, []})
        File.write(
          "rebar.config",
          Enum.map(terms, fn(term) -> :io_lib.format("~tp.~n", [term]) end)
        )
      _ -> IO.puts("no rebar.config found")
    end
  '';

  buildTools = {
    mix = { erlang
          , elixir
          , hex
          , ... }:
          { name
          , version
          , releaseType ? null
          , beamDeps ? []
          , ... }@extraArgs:
      let
        isEscript = releaseType == "escript";
        bootstrapper = ./mix-bootstrap.escript;

        buildEscript = optionalString isEscript ''
          mix escript.build --no-deps-check
          mkdir -p $out/bin
          mv ${name} $out/bin/${name}
        '';

      in
        stdenv.mkDerivation ({
          pname = name;
          inherit version;

          propagatedBuildInputs = [ erlang hex elixir ] ++ beamDeps;

          MIX_ENV = "prod";
          LC_ALL = "en_US.UTF-8";
          LOCALE_ARCHIVE = lib.optionalString stdenv.isLinux
            "${glibcLocales}/lib/locale/locale-archive";

          setupHook = writeText "setupHook.sh" ''
            addToSearchPath ERL_LIBS "$1/lib/erlang/lib"
          '';

          configurePhase = ''
            runHook preConfigure
            ${erlang}/bin/escript ${bootstrapper}
            runHook postConfigure
          '';

          buildPhase = ''
            if [[ -d config && ! -e config/prod.exs ]];
              then touch config/prod.exs;
            fi

            runHook preBuild
            mix compile --no-deps-check
            runHook postBuild
          '';

          installPhase = ''
            mix_build_env=prod
            if [ -d "_build/shared" ]; then
              mix_build_env=shared
            fi

            runHook preInstall

            ${buildEscript}

            mkdir -p "$out/lib/erlang/lib/${name}-${version}"
            for reldir in src ebin priv include; do
              fd="_build/$mix_build_env/lib/${name}/$reldir"
              [ -d "$fd" ] || continue
              cp -Hrt "$out/lib/erlang/lib/${name}-${version}" "$fd"
              success=1
            done

            runHook postInstall
          '';
        } // extraArgs);

    rebar3 = { buildRebar3, elixir, ... }:
             { name
             , version
             , beamDeps
             , ...}@extraArgs:
      buildRebar3 ({
        pname = name;
        inherit version;
        beamDeps = beamDeps;
        preBuild = ''
          rm -f rebar.lock
          ${elixir}/bin/elixir ${rewriteRebarConfig}
        '';
      } // extraArgs);

    rebar = buildTools.rebar3;

    make = { buildErlangMk, ... }:
           { name
           , version
           , beamDeps
           , ...}@extraArgs:
      buildErlangMk ({
        pname = name;
        inherit version;
        beamDeps = beamDeps;
      } // extraArgs);
  };

  srcWithout = rootPath: ignoredPaths:
    let ignoreStrings = map (path: toString path ) ignoredPaths;
    in filterSource (path: type: (all (i: i != path) ignoreStrings)) rootPath;

in rec {
  resolveSrc = dependency:
    if dependency ? fetchHex then
      fixHex ( { inherit (dependency) name version; } // dependency.fetchHex )
    else if dependency ? fetchGit then
      fetchGit dependency.fetchGit
    else if dependency ? src then
      dependency.src
    else
      throw "Couldn't figure out how to fetch ${dependency}"
    ;

  mkPureMixPackage = { importedMixNix
                     , name
                     , version
                     , erlang        ? beam.interpreters.erlang
                     , elixir        ? beam.interpreters.elixir
                     , hex           ? (beam.packagesWith erlang).hex
                     , rebar3        ? (beam.packagesWith erlang).rebar3
                     , buildRebar3   ? (beam.packagesWith erlang).buildRebar3
                     , buildErlangMk ? (beam.packagesWith erlang).buildErlangMk
                     , mixConfig     ? {}
                     , beamDeps      ? {}
                     , ... }@args:
    let
      # recursively populate the beamDeps with actual derivations
      beamDepAttrs = mapAttrs (key: value:
        let
          resolvedSrc = resolveSrc ({ name = key; } // value);

          exactBeamDepNames = optionals (value ? deps) value.deps;
          exactBeamDeps = map (depName: beamDepAttrs."${depName}") exactBeamDepNames;

          # since mix doesn't tell us which dependencies might be needed for
          # packages from git, we have to include all of them (while avoiding
          # infinite recursion).
          # this means we have to filter for git dependencies or things that depend
          # on git dependencies, recursively!
          gitDepNamesWithoutAncestry = filterAttrs (name: dep:
            let
              isGit = depdep: (depdep ? fetchGit && !(depdep ? deps)) || hasGitDep depdep;
              hasGitDep = depdep: any (depName: isGit importedMixNix.${depName}) (lib.optionals (depdep ? deps) depdep.deps);
            in
              !(isGit dep)
          ) importedMixNix;

          gitDepsWithoutAncestry = map (depName: beamDepAttrs."${depName}") (attrNames gitDepNamesWithoutAncestry);

          basicArgs = {
            name = key;
            version = value.version;
            beamDeps = if value ? fetchGit && !(value ? deps)
              then gitDepsWithoutAncestry
              else exactBeamDeps;
            src = resolvedSrc;
          };

          givenConfig = optionalAttrs (mixConfig ? "${key}") (mixConfig."${key}" basicArgs);
          combinedConfig = { buildTool = value.buildTool; } // basicArgs // givenConfig;
        in
          buildTools."${combinedConfig.buildTool}" {
            inherit erlang elixir hex buildRebar3 buildErlangMk;
          } combinedConfig
      ) importedMixNix;

      mixArgs = {
        beamDeps = (attrValues beamDepAttrs) ++ beamDeps;
      } // (filterAttrs (n: v:
        n != "importedMixNix" &&
        n != "mixConfig" &&
        n != "buildTool" &&
        n != "beamDeps"
      ) args);
    in
      buildTools.mix { inherit hex erlang elixir; } mixArgs;

  mkMixPackage = { mixNix ? null  # the mix.nix file
                 , mixLock ? null # the mix.lock file
                 , name
                 , ... }@args:
    if mixNix != null then
      mkPureMixPackage ({ importedMixNix = import mixNix; } // args)
    else
      buildTools.mix args;

}
