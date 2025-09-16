{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOptionDefault
    ;

  cfg = config.chaos.services.flatpak;
in
{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  options.chaos.services.flatpak = {
    enable = mkEnableOption "flatpak service";
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
            "gnome"
          ];
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        # xdg-desktop-portal-kde
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
