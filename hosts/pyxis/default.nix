{ config, pkgs, ... }:
{
  device = "pyxis";
  flavor = "lineageos";
  androidVersion = 11;
  buildDateTime = 1646166325;

  webview.vanadium = {
    enable = true;
    availableByDefault = true;
  };

  apps = {
    vanadium.enable = true;
    updater = {
      flavor = "lineageos";
      enable = true;
      url = "https://android.croughan.sh";
    };
    fdroid.enable = true;
    seedvault.enable = true;
    prebuilt = {
      molly-im = {
        apk = builtins.fetchurl {
          url = "https://github.com/mollyim/mollyim-android/releases/download/v5.48.3-1/Molly-v5.48.3-1-FOSS.apk";
          sha256 = "1jlf7a30qjan0abbw2a77h67lr47x5skrs35cvb25d4kx442cm30";
        };
      };
#     discord = {
#        apk = pkgs.fetchurl {
#          name = "discord.apk";
#          url = "https://d-07.winudf.com/b/APK/Y29tLmRpc2NvcmRfMTEzMDEwX2Q4MjNhZjNi?_fn=RGlzY29yZCBDaGF0IFRhbGsgSGFuZ291dF92MTEzLjEwIC0gU3RhYmxlX2Fwa3B1cmUuY29tLmFwaw&_p=Y29tLmRpc2NvcmQ&am=NviUlVqqCxi1xV0LA75cGQ&at=1646064499&k=7fdcf9a31580820ff443ca67ce8f4b17621e44f3&r=https%3A%2F%2Fm.apkpure.com%2Fsearch%3Fq%3Ddiscord%26search_type%3D%26search_input_keyword%3D";
#          sha256 = "sha256-xx1G3oNd5LE2TVt44Io5WWH7RHkulB6rIPb38/MEoGc=";
#        };
#      };
#     notion = {
#        apk = pkgs.fetchurl {
#          name = "notion.apk";
#          url = "https://d-08.winudf.com/b/APK/bm90aW9uLmlkXzYzMDBfMjg2NGM3Nzc?_fn=Tm90aW9uIG5vdGVzIGRvY3MgdGFza3NfdjAuNi4zMDBfYXBrcHVyZS5jb20uYXBr&_p=bm90aW9uLmlk&am=zyp0Wnpsn9ZIXcHroa7SWg&at=1646064387&k=e2fae6e02d01635b005bae73dc8b88e2621e4483&r=https%3A%2F%2Fm.apkpure.com%2Fnotion-notes-docs-tasks%2Fnotion.id";
#          sha256 = "sha256-WPn+Lw3WL4kdTBYFL0fViFopNUNNaSl7qvEW+84+C+s=";
#        };
#      };
      mattermost = {
        apk = builtins.fetchurl {
          url = "https://releases.mattermost.com/mattermost-mobile/1.55.1/423/Mattermost-arm64-v8a.apk";
          sha256 = "07xvm4jjyn5wm8jqr269mgr0hwi28sk55a3m230d0pw3bcflbdqb";
        };
      };
    };
  };

  source.dirs."device/xiaomi/pyxis".src = builtins.fetchGit {
    rev = "35b094bca0753e717502d543fc4fed444c84f5c1";
    ref = "lineage-18.1";
    url = "https://github.com/SDM710-Development/android_device_xiaomi_pyxis.git";
    allRefs = true;
  };

  source.dirs."device/xiaomi/sdm710-common".src = builtins.fetchGit {
    rev = "2fd487af25b1d688c7528f26cf6f9e92afdddbef";
    ref = "lineage-18.1";
    url = "https://github.com/SDM710-Development/android_device_xiaomi_sdm710-common.git";
    allRefs = true;
  };

  source.dirs."kernel/xiaomi/sdm710".src = builtins.fetchGit {
    rev = "c4d48d66ae60ac6b027bdbb2b618cef6ac245179";
    ref = "10.0-caf";
    url = "https://github.com/SDM710-Development/android_kernel_xiaomi_sdm710.git";
    allRefs = true;
  };

  source.dirs."vendor/xiaomi".src = builtins.fetchGit {
    rev = "cea60d367ffc7375f410f6aac22c531d1b0c3e37";
    ref = "lineage-18.1";
    url = "https://github.com/SDM710-Development/proprietary_vendor_xiaomi.git";
    allRefs = true;
  };

  source.dirs."hardware/xiaomi".src = builtins.fetchGit {
    rev = "d865b86327017fcc5be6658943f38163eb5e2c1f";
    ref = "lineage-18.1";
    url = "https://github.com/LineageOS/android_hardware_xiaomi.git";
    allRefs = true;
  };
}
