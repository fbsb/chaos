{
  chaos.system.provides.hibernate = {
    nixos = {
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
