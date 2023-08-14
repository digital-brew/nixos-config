{ pkgs, ... }: 

{
  accounts = {
    email = {
      accounts = {
        "rafal@mailowl.co" = {
          address = "rafal@mailowl.co";
          imap = {
            host = "imap.dreamhost.com";
            port = 993;
          };
          smtp = {
            host = "smtp.dreamhost.com";
            port = 465;

          };
        };
      };
    };
  };
}