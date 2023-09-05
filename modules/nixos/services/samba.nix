{ pkgs, ...}:

{
  services.samba = {
    enable = true;
    shares = {
      public =
        { path = "/run/media/moonlander/SilverSSD/Swap";
          "read only" = false;
          browseable = "yes";
          "guest ok" = "yes";
          comment = "Shared with W10.";
        };
    };
  };

  # Curiously, `services.samba` does not automatically open
  # the needed ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];
}