{

  # Currently don't need to import this, these are default settings

  program.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;

      character = {
        disabled = false;

        format = "$symbol ";

        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold green)";
        vimcmd_replace_one_symbol = "[❮](bold purple)";
        vimcmd_replace_symbol = "[❮](bold purple)";
        vimcmd_visual_symbol = "[❮](bold yellow)";
      };

      git_branch.symbol = " ";
      git_status = {
        disabled = false;
        ignore_submodules = false;
        
        format = "([\[$all_status$ahead_behind\]]($style) )";
        style = "bold red";

        up_to_date = "";
        modified = "!";
        renamed = "»";
        deleted = "✘";
        untracked = "?";

        conflicted = "=";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";

        stashed = "$";
        typechanged = "";
      };

      # Unchanged from defaults
      lua.symbol = "🌙 ";
      nix_shell.symbol = "❄️  ";
      python.symbol = "🐍 ";

      bun.symbol = "🥟 ";
      daml.symbol = "Λ ";
      dart.symbol = "🎯 ";
      deno.symbol = "🦕 ";
      elm.symbol = "🌳 ";
      gleam.symbol = "⭐ ";
      go.symbol = "🐹 ";
      guix_shell.symbol = "🐃 ";
      gradle.symbol = "🅶 ";
      haskell.symbol = "λ ";
      haxe.symbol = "⌘ ";
      helm.symbol = "⎈ ";
      java.symbol = "☕ ";
      julia.symbol = "ஃ ";
      kotlin.symbol = "🅺 ";
      nodejs.symbol = " ";
      opa.symbol = "🪖 ";
      quarto.symbol = "⨁ ";
      rlang.symbol = "📐 ";
      red.symbol = "🔺 ";
      ruby.symbol = "💎 ";
      rust.symbol = "🦀 ";
      scala.symbol = "🆂 ";
      solidity.symbol = "S ";
      swift.symbol = "🐦 ";
      typst.symbol = "t ";
      vagrant.symbol = "⍱ ";
      vlang.symbol = "V ";
    };
  };
}
