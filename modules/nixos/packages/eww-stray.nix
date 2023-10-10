{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "eww-stray";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "oknozor";
    repo = "stray";
    rev = "v${version}";
    hash = "sha256-5/add1VSJe5ChKi4UU5iUKRAj4kMjOnbB76QX/FkA6k=";
  };

  cargoHash = "sha256-09+8ZqIGaV3A6ZHXtl1b5QiXAgbseA7r6bRJdDIwkW8=";

  meta = with lib; {
    description = "A system tray for eww";
    homepage = "https://github.com/oknozor/stray";
    license = licenses.isc;
    maintainers = with maintainers; [ oknozor ];
    mainProgram = "eww-stray";
    platforms = platforms.linux;
  };
}