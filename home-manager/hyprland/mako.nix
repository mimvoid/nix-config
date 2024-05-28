{ ... }:

{
     services.mako = {
        enable = true;

        anchor = "top-right";

        actions = true;
        defaultTimeout = 5000;
        ignoreTimeout = true;
        maxVisible = 5;

        icons = true;

        borderSize = 1;
        borderRadius = 4;
        padding = "8";

        font = "SauceCodePro Nerd Font Medium 9";

        backgroundColor = "#24273abb"; #transleucent base
        textColor = "#cad3f5"; #catppuccin text
        borderColor = "#f5bde6"; #pink?
        progressColor = "over #363a4f";
    };   
}
