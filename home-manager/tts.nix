{ pkgs, ... }:
let
  amy = pkgs.fetchFromGitHub {
    owner = "sweetbbak";
    repo = "Neural-Amy-TTS";
    rev = "9131abc49bfe028ff823c35add38649987fda17f";
    hash = "sha256-7pOdzA5bwqO1XdXR/rsPUGYFm86HIeuct6KtBH3Qsxw=";
    rootDir = "models/amy_neural";
  };

  piper-models = pkgs.symlinkJoin {
    name = "piper-models";
    paths = [ amy ];
  };
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
