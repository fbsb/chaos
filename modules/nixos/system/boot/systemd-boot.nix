{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.${namespace}.system.boot;
  isSystemd = cfg.loader == "systemd";
in
{
  config = mkIf (cfg.enable && isSystemd) {
    boot.loader.grub.enable = false;
    boot.loader.systemd-boot = {
      enable = true;
      editor = false;
      rebootForBitlocker = true;
      configurationLimit = 10;
      consoleMode = "max";
    };
  };
}
