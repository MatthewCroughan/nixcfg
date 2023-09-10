{
  boot = {
    kernelParams = [
      "iommu=pt"
      "vfio-pci.ids=c0a9:5407,c0a9:0100"
    ];
    kernelModules = [
      "vfio-pci"
    ];
  };
}
