{
  programs.freetube = {
    enable = true;
    settings = 
    let
      # For SponsorBlock
      sk = "autoSkip";
      cfg = { color = "Orange"; skip = "showInSeekBar"; }; # Temporary settings
    in
    {
      allSettingsSectionsExpandedByDefault = true;

      # General settings
      checkForUpdates = true;
      backendFallback = true;
      checkForBlogPosts = false;
      enableSearchSuggestions = true;

      backendPreference = "local";
      listType = "grid";
      landingPage = "subscriptions";

      # Theme settings
      barColor = false; # Whether the top bar matches the main color
      expandSidebar = true;
      hideLabelsSideBar = true;
      hideHeaderLogo = true;

      uiScale = 125;

      baseTheme = "catppuccinMocha";
      mainColor = "CatppuccinMochaMaroon";
      secColor = "CatppuccinMochaLavender";

      # Player settings
      defaultTheatreMode = true;
      videoVolumeMouseScroll = true;
      autoplayVideos = true;
      defaultVolume = 1.0;
      enableScreenshot = true;
      screenshotAskPath = true;

      # Distriction settings
      hideTrendingVideos = true;
      hidePopularVideos = true;
      hideSubscriptionsShorts = true;
      hideSubscriptionsLive = true;
      hideChannelShorts = true;
      hideLiveChat = true;

      playNextVideo = false;
      hideRecommendedVideos = true;
      hideLiveStreams = true;

      # SponsorBlock settings
      useSponsorBlock = true;
      sponsorBlockShowSkippedToast = true;

      sponsorBlockSelfPromo = {
        color = "Yellow";
        skip = sk;
      };
      sponsorBlockInteraction = {
        color = "Green";
        skip = sk;
      };
      sponsorBlockIntro = cfg;
      sponsorBlockOutro = cfg;
      sponsorBlockRecap = cfg;
      sponsorBlockFiller = cfg;
    };
  };
}
