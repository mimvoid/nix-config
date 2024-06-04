{ ... }:
let
  source = catppuccinMacchiato;
in
{
    palette = {
        text = source.text;
        tintedText = source.rosewater;
        base = source.base;
        line = source.surface0;
        frame = source.surface1;

        mainAccent = source.flamingo;
        secAccent = source.pink;
        dullAccent = source.mauve;

        watch = source.maroon;
        warning = source.lavender;
        alert = source.teal;
      };
}
