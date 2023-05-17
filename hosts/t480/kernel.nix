{ pkgs, inputs, ... }:

{
  boot.kernelPatches = let
    pickPatch = x: "${inputs.kernel-clr}/${x}";
    patchFiles = map pickPatch [
      "0104-pci-pme-wakeups.patch"
      "0105-ksm-wakeups.patch"
      "0108-smpboot-reuse-timer-calibration.patch"
      "0111-ipv4-tcp-allow-the-memory-tuning-for-tcp-to-go-a-lit.patch"
      "0112-init-wait-for-partition-and-retry-scan.patch"
      "0118-add-scheduler-turbo3-patch.patch"
      "0120-do-accept-in-LIFO-order-for-cache-efficiency.patch"
      "0121-locking-rwsem-spin-faster.patch"
      "0128-itmt_epb-use-epb-to-scale-itmt.patch"
      "0130-itmt2-ADL-fixes.patch"
      "scale.patch"
      "kvm-printk.patch"
      "libsgrowdown.patch"
      "epp-retune.patch"
    ];
    patches = map builtins.readFile patchFiles;
    patchSet = builtins.concatStringsSep "\n" patches;
    patch = pkgs.writeText "kernel-clr-combined.patch" patchSet;
  in [{
    inherit patch;
    name = "Clear Linux* patchset";
  }];
}

