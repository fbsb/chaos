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
      description = "Wether to enable the ${namespace} home manager defaults";
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    ${namespace} = mkDefaultValues {
      apps.ghostty.enable = true;
      apps.zen-browser.enable = true;
      cli.git.enable = true;
      crypto.gpg.enable = true;
      services.flatpak.enable = true;
    };
  };
}
