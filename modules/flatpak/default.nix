# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: FLATPAK
# Type: Module (NixOS)
# Location: /modules/flatpak/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:
let
#  flatpaks = ''
#    "io.github.Figma_Linux.figma_linux"
#    "io.beekeeperstudio.Studio"
#    "com.yubico.yubioath"
#  '';
  flatpaks = ''
    "com.jetbrains.PhpStorm"
  '';
in
{
  options.customModules.flatpak = {
    enable = lib.mkEnableOption "Whether to enable flatpak.";
  };

  config = lib.mkIf config.customModules.flatpak.enable {
   services.flatpak.enable = true;
   system.activationScripts = {
     flatpak.text =
       ''
         flatpaks=${flatpaks}

         ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

         for package in ''${flatpaks[*]}; do
           check=$(${pkgs.flatpak}/bin/flatpak list --app | ${pkgs.gnugrep}/bin/grep $package)
           if [[ -z "$check" ]] then
             ${pkgs.flatpak}/bin/flatpak install -y flathub $package
           fi
         done

         installed=($(${pkgs.flatpak}/bin/flatpak list --app | ${pkgs.gawk}/bin/awk -F$'\t*' '{$1=$3=$4=$5=""; print $0}'))

         for remove in ''${installed[*]}; do
           if [[ ! " ''${flatpaks[*]} " =~ " ''${remove} " ]]; then
             ${pkgs.flatpak}/bin/flatpak uninstall -y $remove
             ${pkgs.flatpak}/bin/flatpak uninstall -y --unused
           fi
         done
       '';
     };

     # Required for flatpak with window managers
     xdg.portal.enable = true;
  };
}
