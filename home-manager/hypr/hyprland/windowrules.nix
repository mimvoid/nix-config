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
  layerrule = [
    "animation popin 65%, launcher"
    "ignorezero, launcher"
    "blur, launcher"
    "xray 0, launcher"
    "dimaround, launcher"
  ];

  windowrule = [ "pseudo, fcitx" ];

  windowrulev2 = with opacity;
    [
      (more { id = "title"; } "*Nextcloud")
      (more { } "Anki")
      (more { } "org.pwmt.zathura")
      (more { } "com.github.flxzt.rnote")

      (high "obsidian")
      (high "vesktop")
      (high "ristretto")

      (active "firefox")
      (active "zen")
      (active "FFPWA*")
      (active "libreoffice*")
      (active "FreeTube")

      (full "krita")
      (full "org.inkscape.Inkscape")
      (full "org.kde.digikam")
      (full "virt-manager")
    ]
    ++ [
      "suppressevent maximize, class:.*"
      "opacity 0.8 override 0.7 override, class:(${terminal})"

      "float, class:(io.Astal.astal)"

      # For some Krita plugin windows
      "xray 0, class:^krita$, floating:1"
      "noinitialfocus, class:^krita$, floating:1"
      "noblur 1, class:^krita$, floating:1"
      "noborder 1, class:^krita$, floating:1"
      "noshadow 1, class:^krita$, floating:1"

      # Make Zotero plugin notifications less intrusive
      "float, class:^(Zotero)$, title:^(Progress)$"
      "noinitialfocus, class:^(Zotero)$, title:^(Progress)$"
      "move 100% 100%, class:^(Zotero)$, title:^(Progress)$"
      "maxsize 75 50, class:^(Zotero)$, title:^(Progress)$"
    ];
}
