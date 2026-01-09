{
  chaos.goxlr = {
    nixos = {
      services.goxlr-utility = {
        enable = true;
      };
    };

    homeManager =
      {
        config,
        ...
      }:
      {
        home.file = {
          "goxlr-settings" = {
            source = ./settings.json;
            target = "${config.home.homeDirectory}/.config/goxlr-utility/settings.json";
            force = true;
          };
          "goxlr-profiles" = {
            target = "${config.home.homeDirectory}/.local/share/goxlr-utility/profiles";
            source = ./profiles;
            recursive = true;
            force = true;
          };
          "goxlr-mic-profiles" = {
            target = "${config.home.homeDirectory}/.local/share/goxlr-utility/mic-profiles";
            source = ./mic-profiles;
            recursive = true;
            force = true;
          };
        };
      };
  };
}
