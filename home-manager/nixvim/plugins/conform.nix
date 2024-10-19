{ pkgs, ... }:

{
  home.packages = with pkgs; [
    prettierd
    #shellcheck-minimal
    #shellharden
    #shfmt
    black
    isort
  ];

  programs.nixvim.plugins.conform-nvim = {
    enable = true;

    settings = {
      format_on_save.lsp_format = "fallback";

      formatters_by_ft = {
        javascript = [ "prettierd" ];
        typescript = [ "prettierd" ];

        css = [ "prettierd" ];
        scss = [ "prettierd" ];

        html = [ "prettierd" ];
        markdown = [ "prettierd" ];

        # bash = [ "shellcheck" "shellharden" "shfmt" ];
        # go = [ "goimports" "gofmt" ];
        python = [ "black" "isort" ];

        "_" = [ "squeeze_blanks" "trim_whitespace" "trim_newlines" ];
      };
    };
  };
}
