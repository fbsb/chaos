{
  chaos.hardware.provides.sensors = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          lm_sensors
        ];
      };
  };
}
