{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.firefoxpwa ];
  
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;
    nativeMessagingHosts = [ pkgs.unstable.firefoxpwa ];
    
    # FIX: currently, these don't seem to apply
    policies = {
      DisableAppUpdate = true;
      PasswordManagerEnabled = false;
      NoDefaultBookmarks = true;
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
    };
  };
}
