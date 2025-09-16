{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.chaos.apps.junction;
  junctionApp =  "re.sonny.Junction.desktop";
in
{
  options.chaos.apps.junction = {
    enable = mkEnableOption "Junction application chooser";
  };

  config = mkIf cfg.enable {

    services.flatpak = {
      packages = [
        "re.sonny.Junction"
      ];
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = junctionApp;
        "x-scheme-handler/http" = junctionApp;
        "x-scheme-handler/https" = junctionApp;
        "x-scheme-handler/about" = junctionApp;
        "x-scheme-handler/unknown" = junctionApp;
        "application/xhtml+xml" = junctionApp;
      };
    };
  };

}
