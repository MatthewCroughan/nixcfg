{ config, pkgs, ... }:
{
  device = "pyxis";
  flavor = "lineageos";
  androidVersion = 12;
  buildDateTime = 1646166327;

  webview.bromite = {
    enable = true;
    availableByDefault = true;
  };
  apps = {
    bromite.enable = true;
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
          url = "https://github.com/mollyim/mollyim-android/releases/download/v5.52.5-2/Molly-v5.52.5-2-FOSS.apk";
          sha256 = "19pkh0f63plf23ifzj7lvgigba90vix4ndzm88isy90nyj8wcf25";
        };
      };
#     discord = {
#        apk = pkgs.fetchurl {
#          name = "discord.apk";
#          url = "https://d-e02.winudf.com/b/APK/Y29tLmRpc2NvcmRfMTQ4MDE0X2RkMzk3ZQ?_fn=RGlzY29yZCBUYWxrIENoYXQgSGFuZyBPdXRfdjE0OC4xNCAtIFN0YWJsZV9hcGtwdXJlLmNvbS5hcGs&_p=Y29tLmRpc2NvcmQ&am=AZkJADuZs_JrH0IYVT3lYA&at=1665972487&download_id=1700207813049289&k=252b70169d79452c4985efe4ffd6e118634e0a8a&r=https%3A%2F%2Fapkpure.com%2Fdiscord-talk-chat-hang-out%2Fcom.discord&uu=https%3A%2F%2Fd-31.winudf.com%2Fb%2FAPK%2FY29tLmRpc2NvcmRfMTQ4MDE0X2RkMzk3ZQ%3Fk%3De56ea27b3e2d686cf74f87d885277ad0634e0a8a";
#          sha256 = "0z6g65hlxv768jlpjv3qb45mcncm8vax52i36lswswamdl12f6ly";
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
}
