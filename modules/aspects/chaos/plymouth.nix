{
  chaos.plymouth = {
    nixos =
      {
        pkgs,
        ...
      }:
      let
        withTheme =
          theme: cfg:
          {
            inherit theme;

            themePackages = with pkgs; [
              # By default we would install all themes
              (adi1090x-plymouth-themes.override {
                selected_themes = [ theme ];
              })
            ];
          }
          // cfg;
      in
      {
        boot = {
          plymouth = withTheme "cuts_alt" {
            enable = true;
          };

          consoleLogLevel = 3;
          initrd.verbose = false;
          kernelParams = [
            "quiet"
            "splash"
            "boot.shell_on_fail"
            "udev.log_priority=3"
            "rd.systemd.show_status=auto"
          ];

          initrd.systemd.enable = true;
        };
      };
  };
}
