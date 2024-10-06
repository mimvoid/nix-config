{ pkgs, ... }:

{
  home.packages = with pkgs; [
    prettierd
    #shellcheck-minimal
    #shellharden
    #shfmt
    #black
    #isort
  ];

  programs.nixvim.plugins.conform-nvim = {
    enable = true;

    formatOnSave.lspFallback = true;

    formattersByFt = {
      javascript = [[ "prettierd" "prettier" ]];
      typescript = [[ "prettierd" "prettier" ]];
      
      css = [[ "prettierd" "prettier" ]];
      scss = [[ "prettierd" "prettier" ]];
      
      html = [[ "prettierd" "prettier" ]];
      markdown = [[ "prettierd" "prettier" ]];
      
      # bash = [ "shellcheck" "shellharden" "shfmt" ];
      # go = [ "goimports" "gofmt" ];
      # python = [ "black" "isort" ];
      
      "_" = [ "squeeze_blanks" "trim_whitespace" "trim_newlines" ];
    };
  };
}
