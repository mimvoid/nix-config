{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "mdopen";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "immanelg";
    repo = "mdopen";
    rev = "94e238d2a77316847c23032e10fe54dbc4d4588e";
    hash = "sha256-L5PU8mECUOHLok8wpT0eiJIksS9U1ov+kbPazsS3zW4=";
  };

  cargoHash = "sha256-ZnhWN2gmrluZ9AkdbD2zgKAE2rSmB7rmq9LIVAs5/Qs=";

  meta = {
    description = "Preview markdown files in a browser";
    homepage = "https://github.com/immanelg/mdopen";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}
