{
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      move = {};
      # pairs = {};
      surround = {};
      trailspace = {};

      diff = {
        view = {
          style = "sign";
          signs = { add = "┃"; change = "┃"; delete = "▁"; };
          priority = 5;
        };
      };

      hipatterns = {
        highlighters = let
          key = pattern: group: icon: {
            inherit pattern;
            inherit group;
            extmark_opts.sign_text = icon;
          };
        in {
          fixme = key "FIXME:" "MiniHipatternsFixme" "";
          hack = key "HACK:" "MiniHipatternsHack" "";
          todo = key "TODO:" "MiniHipatternsTodo" "";
          note = key "NOTE:" "MiniHipatternsNote" "";
        };
      };

      files = {
        options = {
          permanent_delete = false;
          use_as_default_explorer = true;
        };
        windows = {
          width_focus = 25;
          width_nofocus = 15;
        };
        mappings.go_in_plus = "<cr>";
      };

      clue = {
        triggers.__raw = # lua
        ''
          {
            -- Leader triggers
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },

            -- Built-in completion
            { mode = 'i', keys = '<C-x>' },

            -- `g` key
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },

            -- Marks
            { mode = 'n', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = "'" },
            { mode = 'x', keys = '`' },

            -- Registers
            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'i', keys = '<C-r>' },
            { mode = 'c', keys = '<C-r>' },

            -- Window commands
            { mode = 'n', keys = '<C-w>' },

            -- `z` key
            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },
          }
        '';

        clues.__raw = # lua
        ''
          {
            require('mini.clue').gen_clues.builtin_completion(),
            require('mini.clue').gen_clues.g(),
            require('mini.clue').gen_clues.marks(),
            require('mini.clue').gen_clues.registers(),
            require('mini.clue').gen_clues.windows(),
            require('mini.clue').gen_clues.z(),
          }
        '';
      };
    };
  };
}
