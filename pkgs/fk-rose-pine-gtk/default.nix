{
  stdenvNoCC,
  lib,
  fetchFromGitHub,
  gtk3,
  gtk-engine-murrine,
  variant ? "RosePine-Main-B",
}:

# based on official rose-pine-gtk-theme package

stdenvNoCC.mkDerivation {
  pname = "fk-rose-pine-gtk";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Rose-Pine-GTK-Theme";
    rev = "95aa1f2b2cc30495b1fc5b614dc555b3eef0e27d";
    hash = "sha256-I9UnEhXdJ+HSMFE6R+PRNN3PT6ZAAzqdtdQNQWt7o4Y=";
  };

  nativeBuildInputs = [ gtk3 ];

  propagatedUserEnvPkgs = [
    gtk-engine-murrine # murrine engine for Gtk2
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes/${variant}/
    cp -a themes/${variant}/* "$out/share/themes/${variant}/"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Fausto Korpsvart's Rosé Pine theme for GTK";
    homepage = "https://github.com/Fausto-Korpsvart/Rose-Pine-GTK-Theme";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ];
  };
}
