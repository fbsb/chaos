{
  chaos.system.provides.power = {
    nixos = {
      powerManagement.enable = true;
      systemd.sleep.settings.Sleep = {
        AllowSuspend = true;
        AllowHibernation = true;
        AllowHybridSleep = true;
        AllowSuspendThenHibernate = true;
      };
    };
    services.logind.settings.Login = {
      HandlePowerKey = "hibernate";
    };
  };
}
