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
    enable = mkOption {
      default = true;
      description = "Wether to enable the ${namespace} defaults";
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    ${namespace} = mkDefaultValues {
      # Apply the function here
      desktop.gnome.enable = true;
      services.flatpak.enable = true;
      shell.zsh.enable = true;
      boot.enable = true;
      boot.loader = "grub";
      impermanence.enable = true;
      localization.enable = true;
      programs.base-utils.enable = true;
    };
  };
}
