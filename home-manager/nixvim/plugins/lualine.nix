{
  programs.nixvim.plugins.lualine = {
    enable = true;
    alwaysDivideMiddle = false;
    globalstatus = true;
    iconsEnabled = true;

    componentSeparators = {left = ""; right = "";};
    sectionSeparators = {left = ""; right = "";};
    
    sections = {
      lualine_a = ["mode"];
      lualine_b = ["branch"];
      lualine_c = ["filesize" "filename"];

      lualine_x = [
        "diff"
        "diagnostics"
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
