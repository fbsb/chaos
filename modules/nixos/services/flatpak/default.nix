{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.${namespace}.services.flatpak;
in
{
  options.${namespace}.services.flatpak = {
    enable = mkEnableOption "Enable flatpak system and apps";
  };

  config = mkIf cfg.enable {

    # environment.systemPackages = [
    #   pkgs.flatpak
    # ];

    xdg.portal = {
      enable = true;
      config = {
        common = {
          default = [
            "gtk"
          ];
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        #      xdg-desktop-portal-kde
        #      xdg-desktop-portal-gtk
      ];
    };

    services.flatpak = {
      enable = true;
      remotes = mkOptionDefault [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
        {
          name = "flathub-beta";
          location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }
      ];

      packages = [
        "com.github.tchx84.Flatseal"
      ];

      update.auto = {
        enable = true;
        onCalendar = "daily";
      };

      uninstallUnmanaged = true;
    };
  };
}
