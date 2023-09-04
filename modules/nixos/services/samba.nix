{ pkgs, ...}:

{
  service.samba = {
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
}