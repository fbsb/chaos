{
  chaos.zen-browser = {
    nixos = {
      services.flatpak = {
        packages = [
          "app.zen_browser.zen"
        ];
      };

      # TODO: add config, extensions, etc.
    };
  };
}
