# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: CHAT-GPT
# Type: Imports (NixOS)
# Location: /packages/chat-gpt/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
{
  options.myPackages.chatGPT = {
    enable = lib.mkEnableOption "chat gpt package";
  };

  config = lib.mkIf config.myPackages.chatGPT.enable {
    environment.systemPackages =
    let
      package = pkgs.callPackage ./package.nix {};
    in
      [ package.default ];
  };
}
