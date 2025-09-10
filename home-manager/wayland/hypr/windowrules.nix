{ terminal }:
let
  setRules = params: rules: builtins.map (rule: "${rule}, ${params}") rules;
in
{
  layerrule = setRules "launcher" [
    "animation popin 65%"
    "ignorezero"
    "blur"
    "xray 0"
    "dimaround"
  ];

  windowrulev2 =
    let
      mapClasses = rule: classes: builtins.map (class: "${rule}, class:${class}") classes;
    in
    [
      "float, class:.*astal"
      "workspace 9, class:tauonmb"
    ]
    # Increase opacity somewhat
    ++ (mapClasses "opacity 0.9 override 0.75 override" [
      "Anki"
      ".*zathura"
      ".*rnote"
      terminal
    ])
    # High opacity
    ++ (mapClasses "opacity 0.97 override 0.85 override" [
      "obsidian"
      "vesktop"
      "ristretto"
      "libreoffice.*"
    ])
    # Opaque when focused
    ++ (mapClasses "opacity 1.0 override 0.85 override" [
      "firefox"
      "zen"
      "FFPWA.*"
      "FreeTube"
      "Godot"
      "org.godotengine.Editor"
    ])
    ++ (mapClasses "opaque" [
      "krita"
      ".*Inkscape"
      ".*digikam"
      "virt-manager"
    ])
    # For some Krita plugin windows
    ++ (setRules "class:krita, floating:1" [
      "xray 0"
      "noinitialfocus"
      "noblur"
      "noborder"
      "noshadow"
    ])
    # Shimejis
    ++ (setRules "class:Shijima-Qt, floating:1" [
      "xray 0"
      "noinitialfocus"
      "noblur"
      "noborder"
      "noshadow"
      "opaque"
      "decorate 0"
      "norounding"
    ]);
}
