{
  __findFile ? __findFile,
  ...
}:
{
  chaos.hardware.provides.laptop = {
    includes = [
      <chaos/system/power>
    ];
    nixos = {
      services.logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
      };

      systemd.sleep.extraConfig = ''
        HibernateDelaySec=30m
      '';
    };
  };
}
