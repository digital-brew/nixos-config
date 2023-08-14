{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/quemu-guest.nix")
    ];

  boot = {
    initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "sd_mod" "sr_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/34fe385f-986b-42c7-9022-a896855cc9fb";
      fsType = "ext4";
    };

  swapDevices = [ { device = "/dev/disk/by-uuid/607a2998-4a75-487b-9d41-c96fbdeb5a2a"; } ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
