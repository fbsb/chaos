{
  __findFile ? __findFile,
  ...
}:
{
  chaos.desktop.provides.cosmic = {
    nixos =
      {
        pkgs,
        ...
      }:
      {
        services.displayManager.cosmic-greeter.enable = true;
        services.desktopManager.cosmic.enable = true;
        services.desktopManager.cosmic.xwayland.enable = true;
        services.system76-scheduler.enable = true;
        security.pam.services.login.enableGnomeKeyring = true;

        environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
        environment.sessionVariables.NIXOS_OZONE_WL = "1";

        environment.systemPackages = with pkgs; [
          cosmic-ext-applet-caffeine
          cosmic-ext-applet-privacy-indicator
        ];
      };
  };
}
