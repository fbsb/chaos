{
  chaos.cosmic = {
    nixos = {
      services.displayManager.cosmic-greeter.enable = true;
      services.desktopManager.cosmic.enable = true;
      services.desktopManager.cosmic.xwayland.enable = true;
      environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
  };
}
