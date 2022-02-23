{ pkgs, ... }:

{
  nixpkgs.overlays = [ (self: super: {
    openrgb-51 = self.pkgs.openrgb.overrideAttrs (oldAttrs: rec {
      src = self.fetchFromGitLab {
        owner = "CalcProgrammer1";
        repo = "OpenRGB";
        rev = "b24f989dbc9ecdcb1ae6fe49050f83609ed2b48e";
        sha256 = "192sx9jnzil10qf7vl8w0cp088arbfvv1nv45mnbif94lpfpaqks";
      };
    });
  }) ];

  environment.systemPackages = with pkgs; [
   openrgb-51
 ];

 boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

 services.udev.extraRules = ''
   SUBSYSTEMS=="usb", ATTR{idVendor}=="26CE", ATTR{idProduct}=="01A2", TAG+="uaccess"
   SUBSYSTEMS=="usb", ATTR{idVendor}=="26CE", ATTR{idProduct}=="01A6", TAG+="uaccess"
   SUBSYSTEMS=="usb", ATTR{idVendor}=="2516", ATTR{idProduct}=="0051", TAG+="uaccess"
   KERNEL=="i2c-[0-99]*", TAG+="uaccess"
   KERNEL=="port", TAG+="uaccess"
   KERNEL=="hidraw*", SUBSYSTEM=="hidraw", TAG+="uaccess"
 '';
}

