{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;

  cfg = config.chaos.boot;
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
      default = "saved";
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
