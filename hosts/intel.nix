{ pkgs, ... }:

{
  hardware.graphics.extraPackages = [
    pkgs.intel-media-driver # vaapi
    pkgs.intel-compute-runtime # opencl
    pkgs.libvdpau-va-gl # vdpau
    pkgs.vpl-gpu-rt # oneapi
  ];
}
