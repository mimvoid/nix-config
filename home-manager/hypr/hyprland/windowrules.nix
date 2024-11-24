{ terminal, ... }:
let
  opacity = {
    more = { id ? "class" }: name: "opacity 0.9 override 0.75 override, ${id}:(${name})";
    high = name: "opacity 0.97 override 0.85 override, class:(${name})";
    active = name: "opacity 1.0 override 0.85 override, class:(${name})";
    full = name: "opaque, class:(${name})";
  };
in
{
  windowrule = [ "pseudo, fcitx" ];

  windowrulev2 = with opacity;
    [
      (more { id = "title"; } "*Nextcloud")
      (more { } "Anki")
      (more { } "org.pwmt.zathura")
      (more { } "com.github.flxzt.rnote")

      (high "obsidian")
      (high "vesktop")

      (active "firefox")
      (active "FFPWA*")

      (full "krita")
      (full "org.inkscape.Inkscape")
      (full "virt-manager")
    ]
    ++ [
      "suppressevent maximize, class:.*"
      "opacity 0.8 override 0.7 override, class:(${terminal})"

      # Make Zotero plugin notifications less intrusive
      "float, class:^(Zotero)$, title:^(Progress)$"
      "noinitialfocus, class:^(Zotero)$, title:^(Progress)$"
      "move 100% 100%, class:^(Zotero)$, title:^(Progress)$"
      "maxsize 75 50, class:^(Zotero)$, title:^(Progress)$"
    ];
}
