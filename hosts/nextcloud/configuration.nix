{ config, pkgs, lib, ... }:

{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "DBNC"; # Define your hostname.

  # Enable networking
  networking = {
    networkmanager.enable = true;
    defaultGateway = "5.255.116.1";
    nameservers = ["185.31.172.240" "5.255.125.240"];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
    };
    interfaces = {
      ens3 = {
        ipv4.addresses = [{
          address = "5.255.116.105";
          prefixLength = 24;
        }];
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.graphicfreaq = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  pathsToLink = [ "/share/zsh" ];
  systemPackages = with pkgs; [
    neofetch                                   # system info script
    xarchiver                                  # frontend to 7z, zip, rar, tar, bzip2, gzip, arj, lha, rpm and deb
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.05";

}