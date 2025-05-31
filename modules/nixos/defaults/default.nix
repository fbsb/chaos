{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};

let
  cfg = config.${namespace}.defaults;
in
{
  options.${namespace}.defaults = {
    enable = mkEnableOption "${namespace} defaults" // {
      default = true;
    };
  };

  config = mkIf cfg.enable {
    ${namespace} = mkDefaultValues {
      boot.enable = true;
      boot.loader = "grub";
      desktop.gnome.enable = true;
      hardware.nvidia.enable = true;
      impermanence.enable = true;
      kernel.enable = true;
      localization.enable = true;
      programs.base-utils.enable = true;
      services.flatpak.enable = true;
      shell.zsh.enable = true;
    };
  };
}
