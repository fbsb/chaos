{
  chaos.apps.provides.utils.provides.galaxy-buds-client = {
    nixos =
      {
        pkgs,
        ...
      }:
      {
        services.flatpak.packages = [
          "me.timschneeberger.GalaxyBudsClient"
        ];

        environment.systemPackages = [
          pkgs.earbuds
        ];
      };
  };
}
