# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Name: WORK: HOSTS
# Type: Config (NixOS)
# Location: /hosts/work/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

{ ... }:

{
    networking.hosts = {
        "127.0.0.1" = [
            "local.mammarzenie.org"
            "local.nades.com"
            "local.stratus.earth"
            "local.thearena.network"
            "local.trimit.co.uk"
        ];
    };
}
