{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

# Taken from nur.repos.milahu.cortile

buildGoModule rec {
  pname = "cortile";
  version = "2.5.2";

  src = fetchFromGitHub {
    owner = "leukipp";
    repo = "cortile";
    rev = "v${version}";
    hash = "sha256-2/U7oQO2vOrmoPR+s9VMSWS+d/YqZ5Ic0ieSxSA6SP4=";
  };

  vendorHash = "sha256-VlIPsUogiCQeWWrFsueB6COa91CWIGx3hb7HKC59rS0=";

  env.CGO_ENABLED = 0;

  ldflags = [
    "-s"
    "-w"
    "-X=main.name=cortile"
    "-X=main.version=${version}"
    "-X=main.commit=${src.rev}"
    "-X=main.date=1970-01-01T00:00:00Z"
  ];

  meta = {
    longDescription = ''
      Linux auto tiling manager with hot corner support for
      Openbox, Fluxbox, IceWM, Xfwm, KWin, Marco, Muffin, Mutter and other
      EWMH compliant window managers using the X11 window system. Therefore,
      this project provides dynamic tiling for XFCE, LXDE, LXQt, KDE and GNOME
      (Mate, Deepin, Cinnamon, Budgie) based desktop environments
    '';
    homepage = "https://github.com/leukipp/cortile";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [ ];
    mainProgram = "cortile";
  };
}
