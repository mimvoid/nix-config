{ ... }:

{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    enableDiagnostics = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    enableRefreshOnWrite = true;

    addBlankLineAtTop = true;
    closeIfLastWindow = true;
    sortCaseInsensitive = true;
  };
}
