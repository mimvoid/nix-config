# mimvoid's nixos & home manager configs

This is where I keep my configuration files and links to resources I found helpful, as well as some pieces of advice from my experience with NixOS.

![Screenshot_20240527_000609](https://github.com/mimvoid/nix-config/assets/153698678/3f722d86-e655-4cbb-82a5-9acba1b91ff1)

Note: This repo is a massive work-in-progress, and I only recently got into configuration files at all. Apologies if it's a little messy!

Also: I got some of my [wallpapers](https://github.com/JaKooLit/Wallpaper-Bank) from JaKooLit's [Hyprland dots](https://github.com/JaKooLit/Hyprland-Dots), and don't know the sources. I will track them down once I can!

***

What I use:

- **Terminal**: [foot](https://codeberg.org/dnkl/foot)
- **Editor**: [Nixvim](https://github.com/nix-community/nixvim)
- **File manager**: [Thunar](https://docs.xfce.org/xfce/thunar/start) & [yazi](https://github.com/sxyazi/yazi)
  - I still haven't went through yazi's keymaps yet, but I'll try fully switching to it when I do!
- **Desktop environment**: [KDE Plasma 6](https://kde.org/plasma-desktop/)
- **Music Player**: [Elisa](https://apps.kde.org/elisa/)
- **Cursor**: [Rose Pine Dawn cursor](https://github.com/rose-pine/cursor)
- **GTK icons**: [Rose Pine Moon icons](https://github.com/rose-pine/gtk)
- **Fonts**: [Cantarell](https://cantarell.gnome.org/) & [SauceCodePro Nerd Font](https://www.nerdfonts.com/)
- **Bootable USB**: [Ventoy](https://www.ventoy.net/en/index.html)

And what I will use, but haven't fully migrated over yet:

- **Window manager**: [Hyprland](https://hyprland.org/)
- **Hypr ecosystem**: [hypridle & hyprlock](https://wiki.hyprland.org/Hypr-Ecosystem/)
- **Bar**: [Waybar](https://github.com/Alexays/Waybar)
  - Also considering [yambar](https://codeberg.org/dnkl/yambar/)
- **Notifications**: [mako](https://github.com/emersion/mako)
- **App launcher**: [fuzzel](https://codeberg.org/dnkl/fuzzel)
- **Note-taking app**: [Obsidian](https://obsidian.md/)
  - **Theme**: [AnuPpuccin](https://github.com/AnubisNekhet/AnuPpuccin) with catppuccin macchiato
- **Fonts**: [Limelight](https://fonts.google.com/specimen/Limelight)


# Resources

### NixOS Sources
- [Official NixOS website](https://nixos.org/)
- [Download the Nix package manager & NixOS](https://nixos.org/download/)
  - The Nix package manager has many choices, especially on the unstable channel. However, I'd advise against it if you really want to get into Nix's declarative nature. Unless you just want a good package manager, then be my guest.
- [Nix language guide](https://nix.dev/tutorials/nix-language)
- [Very helpful guide to Nix flakes](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/introduction-to-flakes)
  - Nix flakes may seem daunting at first, but they make it super easy to add extra sources and configuration options. Plus, they're declarative while nix channels are not.
- [Search nix packages](https://search.nixos.org/packages)
- [Search NixOS options](https://search.nixos.org/options)

- [Nix User Repository](https://nur.nix-community.org/)

### Home Manager
A declarative approach to configuring your user environment! It's a lot like NixOS's configuration file, but can be used on other distros too, though not systemwide. I tried it on openSUSE Tumbleweed, but not long-term before trying NixOS. Still, it's pretty nice!

- [Home Manager GitHub page](https://github.com/nix-community/home-manager)
- [Home Manager manual](https://nix-community.github.io/home-manager/)
- [Home Manager configuration options manual](https://nix-community.github.io/home-manager/options.xhtml)
- [Search Home Manager options](https://home-manager-options.extranix.com/)

### Extras
The NixOS configuration file and Home Manager are the two main tools I use, but here are some other modules and tools I like!

- [Awesome Nix: Great collection of Nix resources!](https://github.com/nix-community/awesome-nix)
- [nh: A pretty Nix and Home Manager helper](https://github.com/viperML/nh)
- [NixVim: Configure Neovim and plugins declaratively](https://github.com/nix-community/nixvim)
  - [NixVim documentation](https://nix-community.github.io/nixvim/)
- [Stylix: Quick universal colorschemes and fonts](https://github.com/danth/stylix)
  - [Stylix documentation](https://danth.github.io/stylix/options/nixos.html)
- [Nix-rice: Manage colorschemes](https://github.com/bertof/nix-rice/)
  - It seems less automatic than Stylix, but I'd love to try it out at some point.
- [Plasma-manager: For KDE Plasma](https://github.com/pjones/plasma-manager)
  - Also haven't tried this one extensively, but it seems promising.

# Pieces of Advice

- If you choose to start with a starter config, start small!
  - You can understand a lot by configuring things yourself, and configs that are too complex can confuse you out of touching them.
  - If you really want a config without the manual effort, maybe NixOS is not for you.
- It's absolutely true that NixOS documentation is sparse.
-   If you really want to dig deep, don't be afraid to look through the source code and create your own modules, overlays, and whatever you need to get that configuration! You can do a ton on NixOS, but it takes time, effort, and undoubtly frustration, haha.
- Compared to the rest of Linux, NixOS is a very different distro, but that's what makes me enjoy it!
***
Btw, if you made it this far, thanks! Have a cookie 🍪
