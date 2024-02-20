# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: PACKAGES
# Type: Imports (NixOS)
# Location: /packages/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  imports = [
    ./apple/brcm
    ./apple/fans
    ./chat-gpt
    ./hyprland-workspaces
    ./spatie-ray
    ./stripe-cli
    ./themes/sddm/sugar-candy
    ./thorium-browser
    ./trellis-cli
    ./ulauncher
  ];
}
