{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, wrapGAppsHook
, gtk3
, librsvg
, withWayland ? false
, gtk-layer-shell
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "eww";
  version = "tray-3";

  src = fetchFromGitHub {
    owner = "ralismark";
    repo = "eww";
    rev = "ef386fc1a3b7736603d55a2157aa1059be373aeb";
    hash = "sha256-0v3bxnC0i6kNXbkIKkUXXZEesMwZg79z7T8kA0oDZsM=";
  };

  cargoHash = "sha256-U0vfN0XeFM0Vikspzs3cnAGlK6CxmkXnm8we2uy2Ugc=";

  nativeBuildInputs = [ pkg-config wrapGAppsHook ];

  buildInputs = [ gtk3 librsvg ] ++ lib.optional withWayland gtk-layer-shell;

  buildNoDefaultFeatures = true;
  buildFeatures = [
    (if withWayland then "wayland" else "x11")
  ];

  cargoBuildFlags = [ "--bin" "eww" ];

  cargoTestFlags = cargoBuildFlags;

  # requires unstable rust features
  RUSTC_BOOTSTRAP = 1;

  meta = with lib; {
    description = "ElKowars wacky widgets";
    homepage = "https://github.com/elkowar/eww";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda lom ];
    mainProgram = "eww";
    broken = stdenv.isDarwin;
  };
}



#{ lib
#, rustPlatform
#, fetchFromGitHub
#, pkgs
#}:
#
#rustPlatform.buildRustPackage rec {
#  pname = "eww-wayland";
#  version = "tray-3";
#
#  nativeBuildInputs = [ pkgs.pkg-config pkgs.glib pkgs.gcc pkgs.zlib ];
#
#  src = fetchFromGitHub {
#    owner = "ralismark";
#    repo = "eww";
#    rev = "ef386fc1a3b7736603d55a2157aa1059be373aeb";
#    hash = "sha256-0v3bxnC0i6kNXbkIKkUXXZEesMwZg79z7T8kA0oDZsM=";
#  };
#
#  cargoHash = "sha256-r3wCTIX5cRbUpuwutdpifqYkJz76mnG6Oc7OKzs+aEU=";
#
#  meta = with lib; {
#      description = "ElKowars wacky widgets + systray";
#      homepage = "https://github.com/ralismark/eww";
#      license = licenses.isc;
#      maintainers = with maintainers; [ FieldofClay ];
#      mainProgram = "eww-wayland";
#      platforms = platforms.linux;
#    };
#}

#{ lib, rustPlatform, makeRustPlatform, fetchFromGitHub, pkgs, glib, librsvg, libdbusmenu-gtk3, pkg-config}:
#  let rustPlatform = makeRustPlatform rec {
#    rustc = pkgs.rustc;
#    cargo = pkgs.cargo;
#    pkg-config = pkgs.pkg-config;
#  };
#in
#rustPlatform.buildRustPackage rec {
#  name = "eww-wayland";
#
#  src = fetchFromGitHub {
#    owner = "ralismark";
#    repo = "eww";
#    rev = "ef386fc1a3b7736603d55a2157aa1059be373aeb";
#    hash = "sha256-0v3bxnC0i6kNXbkIKkUXXZEesMwZg79z7T8kA0oDZsM=";
#  };
#
#  cargoHash = "sha256-yVJ36em0lyqJjkzWYBWVBw1C4WfrgVhSSwz6tJyubPk=";
#
#  meta = with lib; {
#    description = "ElKowars wacky widgets + systray";
#    homepage = "https://github.com/ralismark/eww";
#    license = licenses.isc;
#    maintainers = with maintainers; [ FieldofClay ];
#    mainProgram = "eww-wayland";
#    platforms = platforms.linux;
#  };
#}