# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: SPATIE-RAY
# Type: Package (NixOS)
# Location: /packages/spatie-ray/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Source: https://github.com/Alex313031/thorium/releases
{ appimageTools, fetchurl, stdenv }:
let
  icon = ./ray.png;
in
stdenv.mkDerivation rec {
  default = let
    name = "ray";
    version = "2.7.5";
    src = fetchurl {
      url = "https://ray-app.s3.eu-west-1.amazonaws.com/Ray-${version}.AppImage";
      sha256 = "sha256-DgAzfbFO9XpCjZkeGmBU6B9G8XiVwfTjoHioWL7seX8=";
    };
    appimageContents = appimageTools.extractType2 { inherit name src; };
  in
  appimageTools.wrapType2 {
    inherit name version src;
    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/ray.desktop $out/share/applications/ray.desktop
      mkdir -p $out/share/icons/hicolor/512x512/apps
      cp ${icon} $out/share/icons/hicolor/512x512/apps/ray.png
      substituteInPlace $out/share/applications/ray.desktop \
      --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
    '';
  };
}
