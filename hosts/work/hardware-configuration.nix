{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  hardware.apple-t2.enableAppleSetOsLoader = true;

  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation {
      name = "brcm-firmware";

      buildCommand = ''
        dir="$out/lib/firmware"
        mkdir -p "$dir"
        cp -r ${./../../modules/nixos/firmware/work}/* "$dir"
      '';
    })
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    # kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_4.override {
    #   argsOverride = rec {
    #     src = pkgs.fetchurl {
    #           url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
    #           sha256 = "sha256-oyarIkF2xbF8c8nMrYXzLkm25Odkhh1XWVcnt+8QBiw=";
    #     };
    #     version = "6.4.2";
    #     modDirVersion = "6.4.2";
    #     };
    # });
  };

  fileSystems."/" =
    { device = "dev/disk/by-label/system";
#      device = "/dev/disk/by-uuid/d861b1d4-d851-4899-a170-2ac5c9ebf646";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5F66-17ED";
      fsType = "vfat";
    };

  swapDevices = [ ];

  services.hardware.bolt.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
