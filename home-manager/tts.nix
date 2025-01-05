{ pkgs, ... }:
let
  amy = pkgs.fetchFromGitHub {
    owner = "sweetbbak";
    repo = "Neural-Amy-TTS";
    sparseCheckout = [ "models/amy_neural" ];
    rev = "9131abc49bfe028ff823c35add38649987fda17f";
    hash = "sha256-8HJRHRclpub9ogkq2r1COyen/JvHfg60zlkEYnhw0gs=";
  };

  piper-say = pkgs.writeShellScriptBin "piper-say" ''
    echo "$2" \
    | ${pkgs.piper-tts}/bin/piper --model "$1" --output_raw \
    | pw-cat --channels=1 --rate=22050 --format=s16 -p -
  '';

  piper-amy = pkgs.writeShellScriptBin "piper-amy" ''
    ${piper-say}/bin/piper-say ${amy}/models/amy_neural/amy.onnx "$@"
  '';

  piper-amy-fast = pkgs.writeShellScriptBin "piper-amy-fast" ''
    echo "$@" \
    | ${pkgs.piper-tts}/bin/piper --model "${amy}/models/amy_neural/amy.onnx" --output_raw \
    --length_scale 0.7 --sentence_silence 0.1 \
    | pw-cat --channels=1 --rate=22050 --format=s16 -p -
  '';
in
{
  home.packages = [
    pkgs.piper-tts
    piper-say
    piper-amy
    piper-amy-fast
  ];

  # For easier manual access
  xdg.dataFile = {
    "piper/voices/amy.onnx".source = "${amy}/models/amy_neural/amy.onnx";
    "piper/voices/amy.onnx.json".source = "${amy}/models/amy_neural/amy.onnx.json";
  };
}
