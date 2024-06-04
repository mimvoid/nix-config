{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    enableDiagnostics = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    enableRefreshOnWrite = true;

    closeIfLastWindow = true;
    sortCaseInsensitive = true;
    
    filesystem = {
      filteredItems = {
        hideDotfiles = true;
        hideGitignored = true;
        visible = true; # Hidden items are visible but grayed out
      };
      followCurrentFile.enabled = true;
    };

    window.width = 16;
  };
}
