{
  __findFile ? __findFile,
  ...
}:
{
  chaos.hardware.provides.laptop = {
    includes = [
      <chaos/system/power>
      <chaos/hardware/bluetooth>
    ];
    nixos = {
      services.logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
      };

      systemd.sleep.settings.Sleep = {
        HibernateDelaySec = "30m";
      };
    };
  };
}
