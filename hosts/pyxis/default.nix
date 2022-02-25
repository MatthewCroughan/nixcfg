{ config, pkgs, ... }:

{
  device = "pyxis";
  flavor = "lineageos";
  androidVersion = 11;

  source.dirs."device/xiaomi/pyxis".src = builtins.fetchGit {
    rev = "59e33094ff575311ecda0fc983451e8bac93582a";
    ref = "lineage-18.1";
    url = "https://github.com/SDM710-Development/android_device_xiaomi_pyxis.git";
  };

  source.dirs."device/xiaomi/sdm710-common".src = builtins.fetchGit {
    rev = "b831a000fed57d5f66870490257098157ea7c076";
    ref = "lineage-18.1";
    url = "https://github.com/SDM710-Development/android_device_xiaomi_sdm710-common.git";
  };

  source.dirs."kernel/xiaomi/sdm710".src = builtins.fetchGit {
    rev = "beaeaddf970636fe486068484574c13f44248c11";
    ref = "10.0-caf";
    url = "https://github.com/SDM710-Development/android_kernel_xiaomi_sdm710.git";
  };

  source.dirs."vendor/xiaomi".src = builtins.fetchGit {
    rev = "ba97e497ec4b8cc4f2bb14185a3f2f8d6ad454a8";
    ref = "lineage-18.1";
    url = "https://github.com/SDM710-Development/proprietary_vendor_xiaomi.git";
  };

  source.dirs."hardware/xiaomi".src = builtins.fetchGit {
    rev = "d865b86327017fcc5be6658943f38163eb5e2c1f";
    ref = "lineage-18.1";
    url = "https://github.com/LineageOS/android_hardware_xiaomi.git";
  };
}
