<h1 align="center">mimvoid's nixos & home manager dotfiles</h1>

<p align="center">This is where I keep my configuration files, links to helpful resources, and some pieces of advice from my experience with NixOS.

<span align="center">

![2024-06-14-195949_hyprshot](https://github.com/mimvoid/nix-config/assets/153698678/3f3fd85b-64c6-4adf-8987-1d345e00d901)

![2024-06-14-195624_hyprshot](https://github.com/mimvoid/nix-config/assets/153698678/c80bb662-b7f5-434b-8613-a21cd33767ee)

![2024-06-14-201336_hyprshot](https://github.com/mimvoid/nix-config/assets/153698678/075ef3b6-456a-4543-a740-7794d1a0a8d2)

</span>

My Firefox CSS: [panefox](https://github.com/mimvoid/panefox)

My wallpapers and credits: [wallpaper-stash](wallpapers/README.md)

# What I use

Desktop Environments & Window Managers

- [Hyprland](https://hyprland.org/)
- [XFCE](https://xfce.org) with [xfwm](https://docs.xfce.org/xfce/xfwm4/start) 

Display Manager: [LightDM](https://github.com/canonical/lightdm)

| Applications      |                                                                        |
| ----------------- | ---------------------------------------------------------------------- |
| Wayland terminal  | [foot](https://codeberg.org/dnkl/foot)                                 |
| X11 terminal      | [xterm](https://invisible-island.net/xterm/)                           |
| Editor            | [Neovim](https://neovim.io) ([NixVim](https://github.com/nix-community/nixvim)) |
| GUI file manager  | [Thunar](https://docs.xfce.org/xfce/thunar/start)                      |
| TUI file manager  | [yazi](https://github.com/sxyazi/yazi)                                 |
| Web browser       | [Firefox Beta](https://www.mozilla.org/en-US/firefox/channel/desktop/) |
| Art program       | [Krita](https://krita.org)                                             |
| Document viewer   | [Zathura](https://git.pwmt.org/pwmt/zathura/)                          |
| To-do list        | [dooit](https://github.com/kraanzu/dooit)                              |
| Music player      | [Amberol](https://apps.gnome.org/Amberol)                              |

| Hyprland-specific  |                                                       |
| ------------------ | ----------------------------------------------------- |
| Idle               | [hypridle](https://wiki.hyprland.org/Hypr-Ecosystem/) |
| Lockscreen         | [hyprlock](https://wiki.hyprland.org/Hypr-Ecosystem/) |
| Bar                | [Waybar](https://github.com/Alexays/Waybar)           |
| Launcher           | [fuzzel](https://codeberg.org/dnkl/fuzzel)            |
| Notifications      | [mako](https://github.com/emersion/mako)              |
| Logout menu        | [wlogout](https://github.com/ArtsyMacaw/wlogout)      |
| Wallpaper          | [swww](https://github.com/LGFae/swww)                 |
| Screen temperature | [wlsunset](https://sr.ht/~kennylevinsen/wlsunset/)    |
| Screenshot         | [hyprshot](https://github.com/Gustash/hyprshot)       |
| Color picker       | [hyprpicker](https://github.com/hyprwm/hyprpicker)    |

| Theming         |                                                              |
| --------------- | ------------------------------------------------------------ |
| GTK theme       | [Rose Pine Moon](https://github.com/rose-pine/gtk)           |
| Cursor          | [Rose Pine Dawn cursor](https://github.com/rose-pine/cursor) |
| Icons           | [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) with [Catppuccin folders](https://github.com/catppuccin/papirus-folders) |
| Sans serif font | [Cantarell](https://cantarell.gnome.org/)                    |
| Monospace font  | [SauceCodePro Nerd Font](https://www.nerdfonts.com/)         |
| Display font    | [Limelight](https://fonts.google.com/specimen/Limelight)     |

Extras

- WIP: [AGS](https://github.com/Aylur/ags) widgets
- [Obsidian.md](https://obsidian.md) CSS snippets
- Krita
  - Themes
    - [Catppuccin Macchiato & Mocha Maroon](https://github.com/catppuccin/kde)
  - Brushes & Resources
    - [Dirty Chalk for Children](https://krita-artists.org/t/dirty-chalk-for-children-free/39643)
    - [Hollow brush](https://krita-artists.org/t/i-made-a-hollow-brush/92064)
    - [SK Sketching](https://krita-artists.org/t/sk-sketching-in-krita-v1/45795)
    - [Rakurri Gradient Map Set](https://krita-artists.org/t/rakurri-gradient-map-set-free-gradient-maps/33381)
  - Plugins
    - [Composition Helper](https://github.com/Grum999/CompositionHelper)
    - [Reference Tabs Docker](https://invent.kde.org/freyalupen/reference-tabs-docker)
    - [Timer Watch](https://github.com/EyeOdin/timer_watch)
- Firefox themes & extensions
  - Custom themes: Incandescent (light) & Moonflower (dark)
  - [Catppuccin Macchiato - Maroon](https://github.com/catppuccin/firefox)
  - Vertical tabs: [Sidebery](https://addons.mozilla.org/en-US/firefox/addon/sidebery/)

# Resources

### Nix & NixOS Sources

Official:
- [NixOS website](https://nixos.org/)
- [Nix package manager & NixOS download](https://nixos.org/download/)
  - The Nix package manager has many choices, especially on the unstable channel.
  - However, I'd advise against it if you really want to get into Nix's declarative nature. Unless you just want a good package manager, then go ahead.
- [Nix ecosystem documentation](https://nix.dev)
  - [Nix language guide](https://nix.dev/tutorials/nix-language)
- [Search Nix packages](https://search.nixos.org/packages)
- [Search NixOS options](https://search.nixos.org/options)

Unofficial:

- [Awesome Nix](https://github.com/nix-community/awesome-nix)
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world)
  - [Very helpful guide to Nix flakes](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/introduction-to-flakes)
    - Nix flakes may seem daunting at first, but they make it super easy to add extra sources and configuration options. Plus, they're declarative while nix channels are not.
- [Nix User Repository](https://nur.nix-community.org/)
- [User-maintained NixOS wiki](https://nixos.wiki)
  - [Nix applications and ecosystem](https://nixos.wiki/wiki/Applications)
- [Remember to optimize your NixOS storage](https://www.reddit.com/r/NixOS/comments/1cunvdw/friendly_reminder_optimizestore_is_not_on_by/)

### Home Manager
A declarative approach to configuring your user environment! It's very much like NixOS's configuration file, but just for the home directory. It's great if you want to tinker without adding a bunch of generations to your boot menu, or use different configurations for users on the same system.

It can work on other distros too—I tried it on openSUSE Tumbleweed, though not long-term.

- [Home Manager](https://github.com/nix-community/home-manager)
- [Home Manager manual](https://nix-community.github.io/home-manager/)
- [Home Manager configuration options manual](https://nix-community.github.io/home-manager/options.xhtml)
- [Search Home Manager options](https://home-manager-options.extranix.com/)

### Extras
The NixOS configuration file and Home Manager are what I mainly use, but here are some other interesting tools.

- [nh](https://github.com/viperML/nh), a pretty wrapper & helper for Nix and Home Manager
- [NixVim](https://github.com/nix-community/nixvim), for configuring Neovim and its plugins declaratively
  - [NixVim documentation](https://nix-community.github.io/nixvim/)
- [Stylix](https://github.com/danth/stylix), for quick universal colorschemes and fonts
  - [Stylix documentation](https://danth.github.io/stylix/options/nixos.html)
- [Nix-colors](https://docs.xfce.org/xfce/xfwm4/start), for managing color palettes
- [Nix-rice](https://github.com/bertof/nix-rice/), for managing color palettes
- [Plasma-manager](https://github.com/pjones/plasma-manager), for configuring KDE Plasma declaratively
- [System Manager](https://github.com/numtide/system-manager), for managing system configuration with Nix

# Pieces of Advice

- Use `nix path-info nixpkgs#<package-name>` if at all possible
  - Trust me, it is *not* fun to manually search through nix/store/ to find the path to a specific package file.
  - The sooner you're aware of this, the better!
- If you choose to start with a starter config, start small!
  - You can understand a lot by configuring things yourself, and configs that are too complex may confuse you out of touching them.
  - If you really want a config without the manual effort, NixOS is probably not for you.
- It's absolutely true that NixOS documentation is sparse.
  - If you really want to dig deep, don't be afraid to look through the source code or the manuals.
  - You can do a ton on NixOS, but it takes time, effort, and undoubtly frustration.
- You don't need to rely on the options NixOS and Home Manager give you to create config files
  - NixOS has `environment.etc."path/file.type"`, meaning etc/path/file.type
  - Home Manager has `home.file."path/file.type"`, meaning home/user/path/file.type, and `xdg.configFile."path/file.type"`, meaning ~/.config/path/file.type!
  - Optionally, you can use `"path/file.type".source = config.lib.file.mkOutOfStoreSymlink /absolute/path/to/source/file` to symlink an existing file to the location you want
  - Or create your own modules.
- NixOS works very differently to other Linux distros, but that's why I enjoy it!
