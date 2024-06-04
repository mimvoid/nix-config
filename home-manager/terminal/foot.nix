# Colors and fonts are managed by Stylix
{
    programs.foot = {
        enable = true;
        settings = {
            main.pad = "12x0";
            scrollback = {
                lines = 1000;
                indicator-position = "fixed";
                indicator-format = "percentage";
            };
            cursor = {
                style = "block";
                unfocused-style = "hollow";
            };
            mouse = {
                hide-when-typing = "yes";
            };
        };
    };
}
