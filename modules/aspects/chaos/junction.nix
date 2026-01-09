{
  chaos.junction = {
    nixos =
      let
        junctionApp = "re.sonny.Junction";
        junctionAppTarget = junctionApp + ".desktop";
      in
      {
        services.flatpak = {
          packages = [
            junctionApp
          ];
        };

        xdg.mime = {
          enable = true;
          defaultApplications = {
            "text/html" = junctionAppTarget;
            "x-scheme-handler/http" = junctionAppTarget;
            "x-scheme-handler/https" = junctionAppTarget;
            "x-scheme-handler/about" = junctionAppTarget;
            "x-scheme-handler/unknown" = junctionAppTarget;
            "application/xhtml+xml" = junctionAppTarget;
          };
        };
      };
  };
}
