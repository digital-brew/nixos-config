# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: QEMU
# Type: Module (NixOS)
# Location: /modules/qemu/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ lib, config, pkgs, ... }:

{
  options.customModules.qemu = {
    enable = lib.mkEnableOption "Whether to enable qemu, open source machine emulator and virtualizer.";
  };

  config = lib.mkIf config.customModules.qemu.enable {                                   # Add libvirtd and kvm to userGroups
    boot.extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_nsrs=1
    '';                                         # Needed to run OSX-KVM

    users.groups.libvirtd.members = [ "root" "moonlander" ];

    virtualisation = {
      libvirtd = {
        enable = true;                          # Virtual drivers
        #qemuPackage = pkgs.qemu_kvm;           # Default
        qemu = {
          verbatimConfig = ''
           nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
          '';
        };
      };
      spiceUSBRedirection.enable = true;        # USB passthrough
    };

    environment = {
      systemPackages = with pkgs; [
        virt-manager
        virt-viewer
        virtiofsd
        qemu
        OVMF
        gvfs                                    # Used for shared folders between Linux and Windows
        freerdp
      ];
    };

    services = {                                # Enable file sharing between OS
      gvfs.enable = true;
    };
  };
}
