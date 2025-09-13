{ pkgs
, osConfig
, ...
}:
let
  user = "fbsb";
in
{

  home.username = osConfig.users.users.${user}.name;
  home.homeDirectory = osConfig.users.users.${user}.home;

  home.packages = [
    pkgs.usbutils
  ];

  chaos = {
    cli.git = {
      userName = "Fabian Sabau";
      userEmail = "git@fbsb.dev";
    };
  };

  home.stateVersion = "25.05"; # WARN: Changing this might break things. Just leave it.
}
