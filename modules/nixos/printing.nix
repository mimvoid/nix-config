{ pkgs, ... }:

{
  # CUPS
  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr ];
  };

  programs.system-config-printer.enable = true;
}
