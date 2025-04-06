{
  config,
  lib,
  namespace,
  ...
}:

with lib;

let
  cfg = config.${namespace}.apps.zen-browser;
in
{
  options.${namespace}.apps.zen-browser = {
    enable = mkEnableOption "Enable zen browser";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      packages = [
        "app.zen_browser.zen"
      ];
    };
  };
}
