{
  config,
  lib,
  namespace,
  ...
}:

with lib;

let
  cfg = config.${namespace}.services.flatpak;
in
{
  options.${namespace}.services.flatpak = {
    enable = mkEnableOption "Enable flatpak system and apps";
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
