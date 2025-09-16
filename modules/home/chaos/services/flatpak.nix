{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.chaos.services.flatpak;
in
{

  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  options.chaos.services.flatpak = {
    enable = mkEnableOption "flatpak service";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;

      update.auto = {
        enable = true;
        onCalendar = "daily";
      };

      uninstallUnmanaged = true;
    };
  };
}
