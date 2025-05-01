{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.hellwal
  ];
}
