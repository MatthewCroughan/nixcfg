{ config, pkgs, ... }:

{
  device = "pyxis";
  flavor = "lineageos";

  source.dirs."device/xiaomi/pyxis".src = pkgs.fetchgit {
    deepClone = false;
    fetchSubmodules = false;
    leaveDotGit = false;
    rev = "12317390e31d3a3388e2a2f4d77d5d58bd359289";
    sha256 = "1cg7931cvwppw1hl7vgkwji871p60ch4jva8yc7qqb4zyfqr7dmv";
    url = "https://github.com/SDM710-Development/android_device_xiaomi_pyxis";
  };

  source.dirs."device/xiaomi/sdm710-common".src = pkgs.fetchgit {
    deepClone = false;
    fetchSubmodules = false;
    leaveDotGit = false;
    rev = "e66b81d95e369959d38139bb3683f6748c3f1caf";
    sha256 = "0acxnl0794ig4w4h0ydimm3rss4g36hazp8yyy4mw3s5nhgnz9sy";
    url = "https://github.com/SDM710-Development/android_device_xiaomi_sdm710-common";
  };

  source.dirs."kernel/xiaomi/sdm710".src = pkgs.fetchgit {
    deepClone = false;
    fetchSubmodules = false;
    leaveDotGit = false;
    rev = "d3356877ee598b0e2d24d02c08d97749b9a01c12";
    sha256 = "0gdxqjmnkgihf74y0ic4cp6jv4sw0hqb3b724jfxnq5qdriwnaiv";
    url = "https://github.com/SDM710-Development/android_kernel_xiaomi_sdm710";
  };

  source.dirs."vendor/xiaomi".src = pkgs.fetchgit {
    deepClone = false;
    fetchSubmodules = false;
    leaveDotGit = false;
    rev = "555df2f0c5a12ad969a894d0e34472d1d145038f";
    sha256 = "1zvjmb8wcr8qzd6rz0xpayzxc1q4551m9a9vf8gccfn79sci2h9i";
    url = "https://github.com/SDM710-Development/proprietary_vendor_xiaomi";
  };

  source.dirs."hardware/xiaomi".src = pkgs.fetchgit {
    deepClone = false;
    fetchSubmodules = false;
    leaveDotGit = false;
    rev = "8790ded9b7ee38e509e697cfe1660912bf22f5aa";
    sha256 = "0xwbsybaxwia0dqhl1cgll3xdkk7g9j5zwjgihxk9mjgvwnbxig7";
    url = "https://github.com/LineageOS/android_hardware_xiaomi";
  };
}

