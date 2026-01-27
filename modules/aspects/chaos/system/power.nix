{
  chaos.system.provides.power = {
    nixos = {
      powerManagement.enable = true;
      systemd.sleep.extraConfig = ''
        AllowSuspend=yes
        AllowHibernation=yes
        AllowHybridSleep=yes
        AllowSuspendThenHibernate=yes
      '';
    };
    services.logind.settings.Login = {
      HandlePowerKey = "hibernate";
    };
  };
}
