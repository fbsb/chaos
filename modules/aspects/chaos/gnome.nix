{
  ...
}:
{
  chaos.gnome.nixos =
    {
      pkgs,
      ...
    }:
    let
      extensions = with pkgs.gnomeExtensions; [
        appindicator
        blur-my-shell
        clipboard-indicator
        dash-to-dock
        tiling-shell
      ];
    in
    {
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      services.gnome = {
        core-shell.enable = true;
        games.enable = false;
        gnome-online-accounts.enable = true;
        localsearch.enable = true;
        sushi.enable = true;
        tinysparql.enable = true;
      };

      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-user-docs
      ];

      # Enable fractional scaling
      services.displayManager.gdm.wayland = true;
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      environment.systemPackages =
        with pkgs;
        [
          # utilities
          adwaita-icon-theme
          dconf-editor
          gnome-tweaks
        ]
        ++ extensions;

      programs.dconf.enable = true;
      programs.dconf.profiles = {
        user.databases = [
          {
            settings = {
              "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                enable-hot-corners = false;
                show-battery-percentage = true;
                clock-show-weekday = true;
                clock-show-date = true;
              };
              "org/gnome/desktop/wm/preferences" = {
                button-layout = "appmenu:minimize,maximize,close";
              };
              "org/gnome/shell" = {
                enabled-extensions = map (extension: extension.extensionUuid) extensions;
              };
              "org/gnome/mutter" = {
                edge-tiling = false;
                dynamic-workspaces = true;
              };
            };
          }
        ];
      };

      # TODO: add extension configs
    };
}
