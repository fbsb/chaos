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
  isGrub = cfg.loader == "grub";
in
{
  config = mkIf (cfg.enable && isGrub) {
    boot.loader.systemd-boot.enable = false;
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      enableCryptodisk = true;
      extraEntries = ''
        menuentry "UEFI Setup" {
          fwsetup
        }
      '';
    };
    boot.loader.efi.canTouchEfiVariables = true;
    environment.systemPackages = [ pkgs.efibootmgr ];
  };
}
