{
  chaos.junction = {
    nixos =
      let
        junctionApp = "re.sonny.Junction";
        junctionAppTarget = junctionApp + ".desktop";
      in
      {
        pkgs,
        ...
      }:
      {
        environment.systemPackages = with pkgs; [
          junction
        ];

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
