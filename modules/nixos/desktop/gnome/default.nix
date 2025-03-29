{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:

with lib;

let
  cfg = config.${namespace}.desktop.gnome;
in
{
  options.${namespace}.desktop.gnome = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable GNOME desktop environment";
    };

    extensions = mkOption {
      type = types.listOf types.package;
      default = with pkgs.gnomeExtensions; [
        appindicator
        dash-to-dock
        clipboard-indicator
        blur-my-shell
        sound-output-device-chooser
      ];
      description = "List of GNOME shell extensions to install";
    };
  };

  config = mkIf cfg.enable {
    # Enable the GNOME Desktop Environment
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Install GNOME packages
    environment.systemPackages =
      with pkgs;
      [
        gnome-tweaks
        dconf-editor
        adwaita-icon-theme
      ]
      ++ cfg.extensions;

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
    ];

    # Enable GNOME-related services
    services.gnome = {
      core-utilities.enable = true;
      core-shell.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      tinysparql.enable = true;
      localsearch.enable = true;
      sushi.enable = true;
      games.enable = false;
    };

    # Enable fractional scaling
    services.xserver.displayManager.gdm.wayland = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    services.libinput.enable = true;

    # GNOME default settings
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
              enabled-extensions = map (extension: extension.extensionUuid) cfg.extensions;
            };
            "org/gnome/mutter" = {
              edge-tiling = true;
              dynamic-workspaces = true;
            };
          };
        }
      ];
    };
  };
}
