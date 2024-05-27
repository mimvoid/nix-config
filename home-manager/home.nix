{ inputs, outputs, lib, config, pkgs, ... }:

{
  home.username = "zinnia";
  home.homeDirectory = "/home/zinnia";

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  #---------------#
  # INSTALLATIONS #
  #---------------#

  # Currently installed through zypper:
  # Hyprland
  # xdg-desktop-portal-hyprland

  home.packages = with pkgs; [
    # GUIs
    xfce.thunar
    xfce.thunar-archive-plugin
    gvfs
    zathura

    # Hyprland
    hyprland
    hyprland-protocols
    xdg-desktop-portal-hyprland
    hyprlock
    hypridle
    hyprcursor
    hyprpicker
    waybar
    eww
    mako
    fuzzel
    swaybg
    wlsunset
    wlogout

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  imports = [
      ./terminal.nix
      ./stylix.nix
    ];

  programs.zathura.enable = true;

  services = {
    mako = {
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

    wlsunset = {
      enable = true;
      sunrise = "7:30";
      sunset = "20:00";
      temperature = {
        day = 5000;
        night = 2500;
      };
    };
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    #".bashrc".source = dotfiles/bashrc;
    #".config/hypr/hyprland.conf".source = dotfiles/hypr/hyprland;

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zinnia/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
