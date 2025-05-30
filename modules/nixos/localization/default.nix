{
  config,
  lib,
  namespace,
  ...
}:

with lib;

let
  cfg = config.${namespace}.localization;
in
{
  options.${namespace}.localization = {
    enable = mkEnableOption "system localization";

    timezone = mkOption {
      type = types.str;
      default = "Europe/Berlin";
      description = "The timezone used for the system";
    };

    defaultLocale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "The default locale for the system";
    };

    extraLocale = mkOption {
      type = types.str;
      default = "de_DE.UTF-8";
      description = "Additional locale to be used for locale settings";
    };

    keyMap = mkOption {
      type = types.str;
      default = "";
      description = "The keymap for the console";
    };

    xkbLayout = mkOption {
      type = types.str;
      default = "us,de";
      description = "The keyboard layout for X11";
    };

    xkbVariant = mkOption {
      type = types.str;
      default = "altgr-intl,";
      description = "The keyboard variant for X11";
    };

    xkbOptions = mkOption {
      type = types.str;
      default = "grp:ctrl_shift_bksp_toggle";
      description = "The keyboard options for X11";
    };

  };

  config = mkIf cfg.enable {
    # Set timezone
    time.timeZone = cfg.timezone;

    # Configure locales
    i18n = {
      defaultLocale = cfg.defaultLocale;
      extraLocaleSettings = {
        LC_ADDRESS = cfg.extraLocale;
        LC_IDENTIFICATION = cfg.extraLocale;
        LC_MEASUREMENT = cfg.extraLocale;
        LC_MONETARY = cfg.extraLocale;
        LC_NAME = cfg.extraLocale;
        LC_NUMERIC = cfg.extraLocale;
        LC_PAPER = cfg.extraLocale;
        LC_TELEPHONE = cfg.extraLocale;
        LC_TIME = cfg.extraLocale;
      };
      supportedLocales = [ "all" ];
    };

    # Configure console keymap
    console = if cfg.keyMap != "" then { keyMap = cfg.keyMap; } else { useXkbConfig = true; };

    # Configure X11 keyboard layout if X server is enabled
    services.xserver.xkb = mkIf config.services.xserver.enable {
      layout = cfg.xkbLayout;
      variant = cfg.xkbVariant;
      options = cfg.xkbOptions;
    };
  };
}
