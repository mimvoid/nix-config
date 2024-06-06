{
# Not sure if I'll use this,
# but I'll keep it around if I do

  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings = {
      workspaces = [{
        name = "Zettelkasten";
        path = "../../../../Documents/Obsidian/Zettelkasten";
      }];

      follow_url_func = ''
        function(url)
          -- Open the URL in the default web browser.
          vim.fn.jobstart({"xdg-open", url})
        end
      '';
      new_notes_location = "current_dir";
      open_notes_in = "current";
      preferred_link_style = "wiki";
      attachments = {
        confirm_img_paste = false;
        img_folder = "./Meta/Images";
      };
      completion.nvim_cmp = false;
      picker.name = "telescope.nvim";
      ui = {
        enable = true;

        # TODO: change highlight groups
        hl_groups = {
          ObsidianTodo = {
            bold = true;
            fg = "#f78c6c";
          };
          ObsidianDone = {
            bold = true;
            fg = "#89ddff";
          };
          ObsidianRightArrow = {
            bold = true;
            fg = "#f78c6c";
          };
          ObsidianTilde = {
            bold = true;
            fg = "#ff5370";
          };
          ObsidianRefText = {
            underline = true;
            fg = "#c792ea";
          };
          ObsidianExtLinkIcon = {
            fg = "#c792ea";
          };
          ObsidianTag = {
            italic = true;
            fg = "#89ddff";
          };
          ObsidianHighlightText = {
            bg = "#75662e";
          };
        };

        bullets.char = "•";

        # TODO: change checkboxes
        checkboxes = {
          " " = {
            char = "󰄱";
            hl_group = "ObsidianTodo";
          };
          "x" = {
            char = "";
            hl_group = "ObsidianDone";
          };
          ">" = {
            char = "";
            hl_group = "ObsidianRightArrow";
          };
          "~" = {
            char = "󰰱";
            hl_group = "ObsidianTilde";
          };
        };
        external_link_icon = {
          char = "";
          hl_group = "ObsidianExtLinkIcon";
        };
        highlight_text.hl_group = "ObsidianHighlightText";
        reference_text.hl_group = "ObsidianRefText";
        tags.hl_group = "ObsidianTag";
      };
    };
  };
}
