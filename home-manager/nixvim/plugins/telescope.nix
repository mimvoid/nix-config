{ ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      file-browser = {
        enable = true;
        settings.hidden = {
          file_browser = true;
          folder_browser = true;
        };
      };
      fzf-native.enable = true;
		  media-files.enable = true;
	  };
	};
}
