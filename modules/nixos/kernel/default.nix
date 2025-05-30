{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:

with lib;

let
  cfg = config.${namespace}.kernel;
in
{
  options.${namespace}.kernel = {
    enable = mkEnableOption "kernel module";
    package = mkOption {
      type = types.attrs;
      default = pkgs.linuxPackages_6_14;
      description = "The kernel package to use.";
    };
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = cfg.package;
  };
}
