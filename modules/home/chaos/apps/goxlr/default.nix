{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkPackageOption;
  cfg = config.chaos.apps.goxlr;
in
{
  options = {
    chaos.apps.goxlr = {
      enable = mkEnableOption "goxlr app";

      package = mkPackageOption pkgs "goxlr-utility" { };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = {
      "settings" = {
        source = ./settings.json;
        target = "${config.home.homeDirectory}/.config/goxlr-utility/settings.json";
        force = true;
      };
      "profiles" = {
        target = "${config.home.homeDirectory}/.local/share/goxlr-utility/profiles";
        source = ./profiles;
        recursive = true;
        force = true;
      };
      "mic-profiles" = {
        target = "${config.home.homeDirectory}/.local/share/goxlr-utility/mic-profiles";
        source = ./mic-profiles;
        recursive = true;
        force = true;
      };
    };
  };
}
