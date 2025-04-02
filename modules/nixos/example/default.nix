{
  config,
  lib,
  namespace,
  ...
}:

with lib;

let
  cfg = config.${namespace}.example;
in
{
  options.${namespace}.example = {
    enable = mkEnableOption "Enable example module";
    # add more module options here
  };

  config = mkIf cfg.enable {
    # add your module config here
  };
}
