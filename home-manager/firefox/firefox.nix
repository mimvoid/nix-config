{ inputs, outputs, lib, config, pkgs, ... }: {

    programs.firefox = {
        profiles.userChrome = import ./chrome/userChrome.css";
        profiles.userContent = ./chrome/userContent.css;
    };
}
