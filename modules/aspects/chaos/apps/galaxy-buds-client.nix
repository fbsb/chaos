{
  __findFile ? __findFile,
  ...
}:
{
  chaos.apps.provides.galaxy-buds-client = {
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

  chaos.apps.provides.all.includes = [
    <chaos/apps/galaxy-buds-client>
  ];
}
