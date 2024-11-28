{ pkgs, ... }:

{
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver # vaapi
    intel-compute-runtime # opencl
    libvdpau-va-gl # vdpau
    vpl-gpu-rt # oneapi
  ];
}
