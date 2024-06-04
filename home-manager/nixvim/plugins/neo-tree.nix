{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    enableDiagnostics = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    enableRefreshOnWrite = true;

    closeIfLastWindow = true;
    sortCaseInsensitive = true;
    
    filesystem.filteredItems.hideHidden = false;

    window.width = 16;
  };
}
