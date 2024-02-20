# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: THORIUM-BROWSER
# Type: Package (NixOS)
# Location: /packages/thorium-browser/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Source: https://github.com/Alex313031/thorium/releases
{ appimageTools, fetchurl, stdenv }:

stdenv.mkDerivation rec {
  default = let
    name = "thorium";
    version = "119.0.6045.214";
    src = fetchurl {
      url = "https://github.com/Alex313031/thorium/releases/download/M${version}/Thorium_Browser_${version}.AppImage";
      sha256 = "sha256-lV68WQ22ag3tsa9xnNzlL4xM9hEa4NnlvbsYLt3bH0g=";
    };
    appimageContents = appimageTools.extractType2 { inherit name src; };
  in
  appimageTools.wrapType2 {
    inherit name version src;
    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
      install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
      substituteInPlace $out/share/applications/thorium-browser.desktop \
      --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
    '';
  };
}
