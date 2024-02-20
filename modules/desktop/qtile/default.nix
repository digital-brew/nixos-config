# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: QTILE
# Type: Module (NixOS)
# Location: /modules/desktop/qtile/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ config, lib, pkgs, ... }:

{
  options.customModules.desktop.qtile = {
    enable = lib.mkEnableOption "Whether to enable qtile.";
  };

  config = lib.mkIf config.customModules.desktop.qtile.enable {
    services.xserver.windowManager.qtile = {
      enable = true;
      backend = "x11";
      # package = pkgs.qtile-unwrapped.overrideAttrs(o: {
      #   src = pkgs.fetchFromGitHub {
      #     repo = "qtile";
      #     owner = "digital-brew";
      #     rev = "f46450eef6eb2fab5e6a1037fe46893a8c8cc0ce";
      #     sha256 = "sha256-U2I4yWLSkCao5FXWVd+MqI0IvCw9qUWlzW8+RJtQ26Q=";
      #   };
      # });
      extraPackages = python3Packages: with python3Packages; [
        qtile-extras
      ];
    };
  };
}
