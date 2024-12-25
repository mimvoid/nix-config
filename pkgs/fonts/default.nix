{ pkgs, ... }:

with pkgs;
{
  leggie = callPackage ./leggie { };
  limelight = callPackage ./limelight { };
  ritzflf = callPackage ./ritzflf { };
  ma-shan-zheng = callPackage ./ma-shan-zheng { };
}
