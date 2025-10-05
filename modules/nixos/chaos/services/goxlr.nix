{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.chaos.services.goxlr;
in
{
  options = {
    chaos.services.goxlr = {
      enable = mkEnableOption "goxlr service";
    };
  };

  config = mkIf cfg.enable {
    services.goxlr-utility = {
      enable = true;
    };
  };
}
