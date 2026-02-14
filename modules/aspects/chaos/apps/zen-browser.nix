{
  __findFile ? __findFile,
  ...
}:
{
  chaos.apps.provides.zen-browser = {
    nixos = {
      services.flatpak = {
        packages = [
          "app.zen_browser.zen"
        ];
      };

      # TODO: add config, extensions, etc.
    };
  };

  chaos.apps.provides.all.includes = [
    <chaos/apps/zen-browser>
  ];
}
