{ pkgs, ... }:

with pkgs;
{
  leggie = callPackage ./leggie { };
  limelight = callPackage ./limelight { };
  ma-shan-zheng = callPackage ./ma-shan-zheng { };
}
