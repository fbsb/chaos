{
  __findFile ? __findFile,
  ...
}:
{
  chaos.laptop = {
    includes = [
      <chaos/system/hibernate>
    ];
    nixos = {
      powerManagement.enable = true;

      services.logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
      };

      systemd.sleep.extraConfig = ''
        HibernateDelaySec=30m
      '';
    };
  };
}
