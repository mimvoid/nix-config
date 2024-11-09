{ pkgs, ... }:

{
	programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      package = pkgs.unstable.vimPlugins.nvim-treesitter;

      folding = true;

      nixGrammars = true;
      nixvimInjections = true;

      settings = {
        highlight = {
          enable = true;
          disable = [ "latex" ];
        };

        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<leader>s";
            node_incremental = "<leader>s";
            node_decremental = "<bs>";
          };
        };

        indent.enable = true;
      };
    };

    treesitter-textobjects =
      let
        map = query: desc: { inherit query; inherit desc; };
      in
      {
        enable = true;

        select = {
          enable = true;
          lookahead = true;

          keymaps = {
            "a=" = map "@assignment.outer"  "Select around assignment";
            "i=" = map "@assignment.inner"  "Select inside assignment";
            "l=" = map "@assignment.lhs"    "Select left assignment";
            "r=" = map "@assignment.rhs"    "Select right assignment";

            "ap" = map "@parameter.outer"   "Select around parameter";
            "ip" = map "@parameter.inner"   "Select inside parameter";

            "ai" = map "@conditional.outer" "Select around conditional";
            "ii" = map "@conditional.outer" "Select inside conditional";

            "al" = map "@loop.outer"        "Select around loop";
            "il" = map "@loop.inner"        "Select inside loop";

            "af" = map "@call.outer"        "Select around function call";
            "if" = map "@call.inner"        "Select inside function call";

            "ad" = map "@function.outer"    "Select around method/function definition";
            "id" = map "@function.inner"    "Select inside method/function definition";

            "ac" = map "@class.outer"       "Select around class";
            "ic" = map "@class.inner"       "Select inside class";
          };
        };

        move = {
          enable = true;
          setJumps = true;
          gotoNextStart = {
            "]f" = map "@call.outer"        "Next function call start";
            "]d" = map "@function.outer"    "Next method/function definition start";
            "]c" = map "@class.outer"       "Next class start";
            "]i" = map "@conditional.outer" "Next conditional start";
            "]l" = map "@loop.outer"        "Next loop start";

            "]s" = { query = "@scope"; queryGroup = "locals"; desc = "Next scope"; };
            "]z" = { query = "@fold"; queryGroup = "folds"; desc = "Next fold"; };
          };
          gotoNextEnd = {
            "]F" = map "@call.outer"        "Next function call end";
            "]D" = map "@function.outer"    "Next method/function definition end";
            "]C" = map "@class.outer"       "Next class end";
            "]I" = map "@conditional.outer" "Next conditional end";
            "]L" = map "@loop.outer"        "Next loop end";
          };
          gotoPreviousStart = {
            "[f" = map "@call.outer"        "Prev function call start";
            "[d" = map "@function.outer"    "Prev method/function definition start";
            "[c" = map "@class.outer"       "Prev class start";
            "[i" = map "@conditional.outer" "Prev conditional start";
            "[l" = map "@loop.outer"        "Prev loop start";
          };
          gotoPreviousEnd = {
            "[F" = map "@call.outer"        "Prev function call end";
            "[D" = map "@function.outer"    "Prev method/function definition end";
            "[C" = map "@class.outer"       "Prev class end";
            "[I" = map "@conditional.outer" "Prev conditional end";
            "[L" = map "@loop.outer"        "Prev loop end";
          };
        };

        swap = {
          enable = true;
          swapNext = {
            "<leader>np" = "@parameter.inner";
            "<leader>nd" = "@function.outer";
          };
          swapPrevious = {
            "<leader>pp" = "@parameter.inner";
            "<leader>pd" = "@function.outer";
          };
        };
      };

    rainbow-delimiters.enable = true;
  };
}
