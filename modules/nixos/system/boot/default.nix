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
in
{
  options.${namespace}.system.boot = {
    enable = mkEnableOption "bootloader";

    flavour = mkOption {
      type = types.enum [
        "systemd"
        "grub"
      ];
      default = "grub";
      description = "Boot loader to use. Either 'systemd' or 'grub'.";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      boot.loader.efi.canTouchEfiVariables = true;
    }
    (mkIf (cfg.flavour == "systemd") {
      boot.loader.grub.enable = false;
      boot.loader.systemd-boot = {
        enable = true;
        editor = false;
        rebootForBitlocker = true;
        configurationLimit = 10;
        consoleMode = "max";
      };
    })
    (mkIf (cfg.flavour == "grub") {
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
    })
  ]);
}
