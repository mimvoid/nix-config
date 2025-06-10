{ pkgs, ... }:

with pkgs;
{
  courier-prime-sans = callPackage ./courier-prime-sans { };
  leggie = callPackage ./leggie { };
  limelight = callPackage ./limelight { };
  ritzflf = callPackage ./ritzflf { };
  ma-shan-zheng = callPackage ./ma-shan-zheng { };
}
