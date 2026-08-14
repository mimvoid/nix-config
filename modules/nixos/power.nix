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
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      USB_EXCLUDE_BTUSB = 1;
    };
  };
}
