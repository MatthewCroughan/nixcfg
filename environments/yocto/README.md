# About

###### Based on
https://discourse.nixos.org/t/build-a-yocto-rootfs-inside-nix/2643/23 

###### Enables building of:
https://docs.foundries.io/79/reference-manual/linux/linux-building.html

# Usage

This is a bit hacky. The exporting of `BB_ENV_EXTRAWHITE` after `source
setup-environment` is necessary at this time, for reasons that are beyond my
depth. But hey, it works!

```sh
nix-build yocto.nix
./result/bin/yocto-on-nixos
mkdir lmp && cd lmp 
repo init -u https://github.com/foundriesio/lmp-manifest -b refs/tags/79
repo sync
MACHINE=raspberrypi3-64 source setup-environment
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE LOCALEARCHIVE LOCALE_ARCHIVE"
bitbake lmp-base-console-image
```

