{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.chaos.programs.base-utils;
in
{
  options.chaos.programs.tio = {
    enable = mkEnableOption "tio";
  };

  config = mkIf cfg.enable {
    chaos.users.extraGroups = [ "dialout" ];
    environment.systemPackages = with pkgs; [
      tio
    ];
  };
}
