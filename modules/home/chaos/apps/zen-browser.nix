{ config
, lib
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.chaos.apps.zen-browser;
in
{
  options.chaos.apps.zen-browser = {
    enable = mkEnableOption "Zen browser";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      packages = [
        "app.zen_browser.zen"
      ];
    };
  };
}
