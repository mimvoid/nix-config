{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:

buildGoModule (finalAttrs: {
  pname = "todotui";
  version = "0.7.2";

  src = fetchFromGitHub {
    owner = "yuucu";
    repo = "todotui";
    rev = "v${finalAttrs.version}";
    hash = "sha256-Ey5r+y879UE2aJEu2cMGjzegR282NzplIuDs43M4dkU=";
  };

  vendorHash = "sha256-ybV1Nqr0RzteKzUS8LPj+wPkUH1nVr7uFkqJD26PXMk=";
  checkFlags = [ "-skip=TestGetLogDirectory" ];

  meta = {
    description = "Vim-like TUI that honors the simplicity of todo.txt";
    homepage = "https://github.com/yuucu/todotui";
    mainProgram = "todotui";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
})
