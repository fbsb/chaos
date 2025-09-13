{ config
, lib
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.chaos.boot;
in
{
  options.chaos.boot = {
    enable = mkEnableOption "bootloader";

    loader = mkOption {
      type = types.enum [
        "systemd"
        "grub"
      ];
      default = "grub";
      description = "Boot loader to use. Either 'systemd' or 'grub'.";
    };
  };

  imports = [
    ./grub.nix
    ./systemd-boot.nix
  ];

  config = mkIf cfg.enable {
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
