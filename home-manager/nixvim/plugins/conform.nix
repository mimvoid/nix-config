{ pkgs, ... }:

{
  home.packages = with pkgs; [
    prettierd
    #shellcheck-minimal
    #shellharden
    #shfmt
  ];

  programs.nixvim.plugins.conform-nvim = {
    enable = true;

    settings = {
      formatters_by_ft = {
        javascript = [ "prettierd" ];
        typescript = [ "prettierd" ];

        css = [ "prettierd" ];
        scss = [ "prettierd" ];

        html = [ "prettierd" ];
        markdown = [ "prettierd" ];

        # bash = [ "shellcheck" "shellharden" "shfmt" ];
        # go = [ "goimports" "gofmt" ];

        "_" = [ "squeeze_blanks" "trim_whitespace" "trim_newlines" ];
      };
    };
  };
}
