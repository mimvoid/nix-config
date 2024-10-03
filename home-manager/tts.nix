{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    piper-tts
    speechd
  ];

  xdg.configFile = {
    "speech-dispatcher/speechd.conf".text = ''
      CommunicationMethod "unix_socket"
      SocketPath "default"
      Timeout 30

      LogLevel 3
      LogDir "default"

      DefaultRate 20
      DefaultPitch 20
      DefaultPitchRange 0
      DefaultVolume 100
      DefaultVoiceType "MALE1"
      DefaultLanguage en

      DefaultPunctuationMode "some"

      SymbolsPreproc "char"
      SymbolsPreprocFile "gender-neutral.dic"
      SymbolsPreprocFile "font-variants.dic"
      SymbolsPreprocFile "symbols.dic"
      SymbolsPreprocFile "emojis.dic"
      SymbolsPreprocFile "orca.dic"
      SymbolsPreprocFile "orca-chars.dic"

      DefaultCapLetRecognition  "none"
      DefaultSpelling  Off

      AudioOutputMethod "pulse"
      AudioPulseDevice "default"
      AudioPulseMinLength 10

      AddModule "piper" "sd_generic" "piper.conf"
      DefaultModule "piper"
      LanguageDefaultModule "en" "piper"

      Include "clients/*.conf"
    '';

    "speech-dispatcher/modules/piper.conf".text = ''
      Debug 0

      GenericExecuteSynth "echo \'$DATA\' | ${pkgs.piper-tts}/bin/piper --model ${config.xdg.dataHome}/piper/voices/en_US-lessac-medium.onnx --output_raw | pw-cat --channels=1 --rate=22050 --format=s16 -p -"

      GenericCmdDependency "piper"
      GenericCmdDependency "pw-cat"
      GenericCmdDependency "printf"
      GenericSoundIconFolder "/usr/share/sounds/sound-icons/"

      GenericPunctNone ""
      GenericPunctSome "--punct=\"()<>[]{}\""
      GenericPunctMost "--punct=\"()[]{};:\""
      GenericPunctAll "--punct"

      #GenericStripPunctChars  ""

      GenericLanguage  "en" "en_US" "utf-8"

      AddVoice "en" "MALE1"  "Piper"

      GenericRateForceInteger 20
      GenericPitchForceInteger 20
    '';
  };
}
