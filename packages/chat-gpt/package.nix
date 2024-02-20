# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: CHAT-GPT
# Type: Package (NixOS)
# Location: /packages/chat-gpt/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Source: https://github.com/Alex313031/thorium/releases
{ appimageTools, fetchurl, stdenv }:
let
  icon = ./chatgpt.png;
in
stdenv.mkDerivation rec {
  default = let
    name = "chatgpt";
    version = "1.1.0";
    src = fetchurl {
      url = "https://github.com/lencx/ChatGPT/releases/download/v${version}/ChatGPT_${version}_linux_x86_64.AppImage.tar.gz";
      sha256 = "sha256-8qHjaZ95cIblepIljeRnIvCfaALF/FqdDVSBPm/S8Es=";
    };
    appimageContents = appimageTools.extractType2 { inherit name src; };
  in
  appimageTools.wrapType2 {
    inherit name version src;
    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/chatgpt.desktop $out/share/applications/chatgpt.desktop
      mkdir -p $out/share/icons/hicolor/512x512/apps
      cp ${icon} $out/share/icons/hicolor/512x512/apps/chatgpt.png
      substituteInPlace $out/share/applications/chatgpt.desktop \
      --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
    '';
  };
}
