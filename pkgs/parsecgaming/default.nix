{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let debExtract = stdenv.mkDerivation {
  name = "parsecgaming-pkg";
  src = fetchurl {
    url = "https://s3.amazonaws.com/parsec-build/package/parsec-linux.deb";
    sha256 = "1hfdzjd8qiksv336m4s4ban004vhv00cv2j461gc6zrp37s0fwhc";
    };
  phases = [ "buildPhase" ];
  buildInputs = [ dpkg ];
  buildPhase = ''
    mkdir $out
    dpkg-deb -x $src $out
    # dpkg-deb makes $out group-writable, which nix doesn't like
    chmod 755 $out
    mv $out/usr/* $out
    rmdir $out/usr
  '';
};
in buildFHSUserEnv {
  name = "parsecgaming";
  targetPkgs = pkgs: with pkgs; [
    alsaLib
    wayland
    cups
    dbus
    debExtract
    fontconfig
    freetype
    libGL
    libpulseaudio
    libsamplerate
    libudev
    libva
    libxkbcommon
    nas
    stdenv.cc.cc.lib
    vulkan-loader
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcursor
    xorg.libXext
    xorg.libXi
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXrender
    xorg.libXxf86vm
    xorg.libxcb
    # Those libraries are missing from buildInputs
    # libGLES_CM.so.1        # Can't find in my /nix/store
    # libudev.so.0           # Covered by libudev.so.1
    # libva.so.1             # Covered by libva.so.2
    # libwayland-client.so.0 # No wayland support
    # libwayland-cursor.so.0 # No wayland support
    # libwayland-egl.so.1    # No wayland support
  ];
  runScript = "/usr/bin/parsecd";

  meta = {
    description = "Parsec Gaming Daemon";
    homepage = https://www.parsecgaming.com/;
  };
}

