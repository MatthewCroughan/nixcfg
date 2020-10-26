{ pkgs ? import <nixpkgs> {} }:

let

  bashrcFile = pkgs.writeText "bashrc" ''
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';

  gcc_multi_norpath = pkgs: (pkgs.gcc_multi.override (old: {
    extraBuildCommands = ''
      wrapProgram $out/bin/gcc \
        --set NIX_DONT_SET_RPATH 1 \
        --set NIX_CC_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu 1

      wrapProgram $out/bin/g++ \
        --set NIX_DONT_SET_RPATH 1 \
        --set NIX_CC_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu 1
    '';
  })).overrideAttrs (old: {
      nativeBuildInputs = [ pkgs.makeWrapper ];
  });

in pkgs.buildFHSUserEnvBubblewrap {
  name = "yocto-on-nixos";

  targetPkgs = pkgs: with pkgs; [
    bc file gnumake python3 unzip which patch perl util-linux rsync wget
    diffstat

    gcc glibc glibcLocales shadow  python27 gawk gitFull gitRepo diffutils
    texinfo bzip2 gzip chrpath bash cpio utillinux nettools iproute procps
    openssh xterm SDL findutils socat gnutar ccache cmake vim binutils bash
    bashInteractive rpcsvc-proto

    (gcc_multi_norpath pkgs)
    glibcLocales gdb valgrind

    libglvnd mesa ncurses pkgconfig qt5.qtbase
    bzip2 lzma
  ];

  multiPkgs = pkgs: (with pkgs; []);

  extraOutputsToInstall = [ "dev" ];

  profile = ''
    export hardeningDisable=all

    export CC=gcc
    export LD=ld
    export STRIP=strip
    export OBJCOPY=objcopy
    export RANLIB=ranlib
    export OBJDUMP=objdump
    export AS=as
    export AR=ar
    export NM=nm
    export CXX=g++
    export SIZE=size

    export LANG="C.UTF-8"
    export LC_ALL="C.UTF-8"

    export LOCALEARCHIVE=/usr/lib/locale/locale-archive
    export BB_ENV_EXTRAWHITE="LOCALEARCHIVE LOCALE_ARCHIVE NIX_DONT_SET_RPATH NIX_CC_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu"

    export NIX_DONT_SET_RPATH=1
  '';

  extraBuildCommands = ''
    ln -sf ${pkgs.glibcLocales}/lib/locale/locale-archive $out/usr/lib/locale
  '';

  runScript = "bash --rcfile ${bashrcFile}";
}

