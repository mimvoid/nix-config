{ lib,
  buildGoModule,
  fetchFromGitHub
}:

# Taken from nur.repos.milahu.cortile

buildGoModule rec {
  pname = "cortile";
  version = "2.5.0";

  src = fetchFromGitHub {
    owner = "leukipp";
    repo = "cortile";
    rev = "v${version}";
    hash = "sha256-0i/DWDwGyV6G1eTM7RH+O8sbo7eB6WfUEkUdXrJ0+5I=";
  };

  vendorHash = "sha256-sjZvE7CTHLbdwuLUfhLe9NAGUEiw/8G0f6U5hWYf+kE=";

  ldflags = [
    "-s"
    "-w"
    "-X=main.name=cortile"
    "-X=main.version=${version}"
    "-X=main.commit=${src.rev}"
    "-X=main.date=1970-01-01T00:00:00Z"
  ];

  meta = with lib; {
    description = ''Linux auto tiling manager with hot corner support for
      Openbox, Fluxbox, IceWM, Xfwm, KWin, Marco, Muffin, Mutter and other
      EWMH compliant window managers using the X11 window system. Therefore,
      this project provides dynamic tiling for XFCE, LXDE, LXQt, KDE and GNOME
      (Mate, Deepin, Cinnamon, Budgie) based desktop environments'';
    homepage = "https://github.com/leukipp/cortile";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "cortile";
  };
}
