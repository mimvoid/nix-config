{ inputs, ... }:

{
  imports = [
    "${inputs.aagl.outPath}/module/hosts.nix"
  ];

  networking.mihoyo-telemetry.block = true;
}
