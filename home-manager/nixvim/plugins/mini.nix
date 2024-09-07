{
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      move = {};
      surround = {};
      trailspace = {};

      diff = {
        view = {
          style = "sign";
          signs = { add = "┃"; change = "┃"; delete = "▁"; };
        };
      };

      clue = let
        trig = mode: keys: { inherit mode keys; };
      in
      {
        triggers = [
          # leader
          (trig "n" "<leader>")
          (trig "x" "<leader>")

          # built-in completion
          (trig "i" "<C-x>" )
          
          # g key
          (trig "n" "g" )
          (trig "x" "g" )

          # marks
          (trig "n" "\\'")
          (trig "n" "\\`")
          (trig "x" "\\'")
          (trig "x" "\\`")

          # registers
          (trig "n" "\"")
          (trig "x" "\"")
          (trig "i" "<C-r>")
          (trig "c" "<C-r>")

          # window commands
          (trig "n" "<C-w>")

          # z key
          (trig "n" "z")
          (trig "x" "z")
        ];

        clues = [
          "miniclue.gen_clues.builtin_completion()"
          "miniclue.gen_clues.g()"
          "miniclue.gen_clues.marks()"
          "miniclue.gen_clues.registers()"
          "miniclue.gen_clues.windows()"
          "miniclue.gen_clues.z()"
        ];
      };
    };
  };
}
