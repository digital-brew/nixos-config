# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: HYPRLAND-WORKSPACES
# Type: Package (NixOS)
# Location: /packages/hyprland-workspaces/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ fetchFromGitHub, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "hyprland-workspaces";
  version = "1.2.5";

  src = fetchFromGitHub {
    owner = "FieldofClay";
    repo = "hyprland-workspaces";
    rev = "v${version}";
    hash = "sha256-5/add1VSJe5ChKi4UU5iUKRAj4kMjOnbB76QX/FkA6k=";
  };

  cargoHash = "sha256-kUDo+6fsrzzojHYNMNBYpztGJPPtPp/OXUypUJnzebY=";

  meta = with lib; {
    description = "A multi-monitor aware Hyprland workspace widget";
    homepage = "https://github.com/FieldofClay/hyprland-workspaces";
    license = licenses.isc;
    maintainers = with maintainers; [ FieldofClay ];
    mainProgram = "hyprland-workspaces";
    platforms = platforms.linux;
  };
}
