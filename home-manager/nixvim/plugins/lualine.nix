{
  programs.nixvim.plugins.lualine = {
    enable = true;

    settings = {
      options = {
        always_divide_middle = false;
        icons_enabled = true;
        globalstatus = true;

        disabled_filetypes.statusline = [ "alpha" ];

        component_separators = { left = ""; right = ""; };
        section_separators = { left = ""; right = ""; };
      };

      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          {
            __unkeyed-1 = "filetype";
            padding = { left = 1; right = 0; };
            icon_only = true;
          }
          {
            __unkeyed-1 = "filename";
            padding = { left = 0; right = 1; };
            symbols = {
              modified = "";
              readonly = "󰌾";
            };
          }
          "filesize"
        ];

        lualine_x = [
          "diff"
          {
            __unkeyed-1 = "diagnostics";
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = " ";
            };
          }

          # Show active language server
          {
            __unkeyed-1.__raw = ''
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
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
    };
  };
}
