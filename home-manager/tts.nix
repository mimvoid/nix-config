{ pkgs, ... }:
let
  amy = pkgs.fetchFromGitHub {
    owner = "sweetbbak";
    repo = "Neural-Amy-TTS";
    sparseCheckout = [ "models/amy_neural" ];
    rev = "9131abc49bfe028ff823c35add38649987fda17f";
    hash = "sha256-8HJRHRclpub9ogkq2r1COyen/JvHfg60zlkEYnhw0gs=";
  };

  piper-models = pkgs.runCommand "piper-models" { } ''
    mkdir -p $out
    cp ${amy}/models/amy_neural/* $out
  '';
in
{
  home.packages = [
    pkgs.piper-tts
    pkgs.speechd-minimal
  ];

  xdg.configFile =
    let
      piper-generic = pkgs.writeText "piper-generic.conf" ''
        GenericExecuteSynth \
        "echo \'$DATA\' \
        | ${pkgs.piper-tts}/bin/piper --model \'${piper-models}/$VOICE.onnx\' --output-raw \
        | pw-play --rate=22050 --channel-map=LE --raw -"

        AddVoice "en" "female1" "amy"
        DefaultVoice "amy"
      '';
    in
    {
      "speech-dispatcher/speechd.conf".text = ''
        SymbolsPreproc "char"

        SymbolsPreprocFile "gender-neutral.dic"
        SymbolsPreprocFile "font-variants.dic"
        SymbolsPreprocFile "symbols.dic"
        SymbolsPreprocFile "emojis.dic"
        SymbolsPreprocFile "orca.dic"
        SymbolsPreprocFile "orca-chars.dic"

        DefaultVoiceType "female1"
        DefaultLanguage "en"

        AddModule "pico" "sd_pico" "pico.conf"
        DefaultModule pico

        # For now, I cannot get Piper working consistently...
        # AddModule "piper-generic" "sd_generic" "${piper-generic}"
        # DefaultModule piper-generic

        Include "clients/*.conf"
      '';
    };
}
