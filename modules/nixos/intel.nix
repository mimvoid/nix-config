{ pkgs, lib, ... }:

{
  hardware.graphics.extraPackages = lib.mkAfter [
    pkgs.intel-media-driver # vaapi
    pkgs.vpl-gpu-rt # onevpl

    # OpenCL
    # pkgs.intel-compute-runtime # gen12+
    pkgs.intel-compute-runtime-legacy1 # gen8, gen9, gen11
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Prefer modern iHD backend
  };

  boot.kernelParams = lib.mkAfter [ "intel_iommu=on" ];

  # PCI passthrough
  boot.initrd.kernelModules = lib.mkAfter [ "vfio_pci" "vfio" "vfio_iommu_type1" "i915" ];
}
