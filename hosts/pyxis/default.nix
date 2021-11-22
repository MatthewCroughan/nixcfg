{ config, pkgs, ... }:

{
  device = "pyxis";
  flavor = "lineageos";
  androidVersion = 11;

  source.dirs."device/xiaomi/pyxis".src = builtins.fetchGit {
    rev = "35b094bca0753e717502d543fc4fed444c84f5c1";
    ref = "lineage-18.1";
    url = "https://github.com/SDM710-Development/android_device_xiaomi_pyxis.git";
  };

  source.dirs."device/xiaomi/sdm710-common".src = builtins.fetchGit {
    rev = "2fd487af25b1d688c7528f26cf6f9e92afdddbef";
    ref = "lineage-18.1";
    url = "https://github.com/SDM710-Development/android_device_xiaomi_sdm710-common.git";
  };

  source.dirs."kernel/xiaomi/sdm710".src = builtins.fetchGit {
    rev = "c4d48d66ae60ac6b027bdbb2b618cef6ac245179";
    ref = "10.0-caf";
    url = "https://github.com/SDM710-Development/android_kernel_xiaomi_sdm710.git";
  };

  source.dirs."vendor/xiaomi".src = builtins.fetchGit {
    rev = "cea60d367ffc7375f410f6aac22c531d1b0c3e37";
    ref = "lineage-18.1";
    url = "https://github.com/SDM710-Development/proprietary_vendor_xiaomi.git";
  };

  source.dirs."hardware/xiaomi".src = builtins.fetchGit {
    rev = "d865b86327017fcc5be6658943f38163eb5e2c1f";
    ref = "lineage-18.1";
    url = "https://github.com/LineageOS/android_hardware_xiaomi.git";
  };
}
