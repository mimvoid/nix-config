{ ... }:

{
  services.upower = {
    enable = true;
    usePercentageForPolicy = true;
    percentageLow = 40;
    percentageCritical = 20;

    percentageAction = 5;
    criticalPowerAction = "HybridSleep";
  };

  services.tlp = {
    enable = true;
    settings = {
      USB_EXCLUDE_BTUSB = 1;
    };
  };

  services.auto-cpufreq.enable = true;
}
