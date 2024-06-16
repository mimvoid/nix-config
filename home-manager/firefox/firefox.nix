{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.firefoxpwa ];
  
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox-beta;
    nativeMessagingHosts = [ pkgs.unstable.firefoxpwa ];
    policies = {
      DisableAppUpdate = true;
      PasswordManagerEnabled = false;
      NoDefaultBookmarks = true;
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
    };
  };
}
