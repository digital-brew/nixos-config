# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: OFFICE
# Type: Module (NixOS)
# Location: /modules/office/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.office = {
    enable = lib.mkEnableOption "Whether to enable office programs and services.";
  };

  config = lib.mkIf config.customModules.office.enable {
    environment.systemPackages = with pkgs; [
      chatgpt-cli                               # Interactive CLI for ChatGPT
      gnome.gnome-calendar                      # Simple and beautiful calendar application for GNOME
      gtt                                       # Google Translate TUI (Originally). Now support Apertium, Argos, Bing, ChatGPT, DeepL, Google, Reverso
      libreoffice                               # Comprehensive, professional-quality productivity suite
      libsForQt5.okular                         # KDE document viewer
      pro-office-calculator                     # A completely normal office calculator
      sioyek                                    # A PDF viewer designed for research papers and technical books
    ];
  };
}
