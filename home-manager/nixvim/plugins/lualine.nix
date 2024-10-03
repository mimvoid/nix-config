{
  programs.nixvim.plugins.lualine = {
    enable = true;
    alwaysDivideMiddle = false;
    globalstatus = true;
    iconsEnabled = true;

    disabledFiletypes.statusline = [ "alpha" ];

    componentSeparators = { left = ""; right = ""; };
    sectionSeparators = { left = ""; right = ""; };
    
    sections = {
      lualine_a = ["mode"];
      lualine_b = ["branch"];
      lualine_c = [
        {
          name = "filetype";
          padding = { left = 1; right = 0; };
          extraConfig.icon_only = true;
        }
        {
          name = "filename";
          padding = { left = 0; right = 1; };
          extraConfig.symbols = { modified = ""; readonly = "󰌾"; };
        }
        "filesize"
      ];

      lualine_x = [
        "diff"
        {
          name = "diagnostics";
          extraConfig.symbols = {
            error = " ";
            warn = " ";
            info = " ";
            hint = " ";
          };
        }

        # Show active language server
        {
          name.__raw = ''
            function()
              local msg = ""
              local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end
          '';
        }
      ];
      lualine_y = ["progress"];
      lualine_z = ["location"];
    };
  };
}
