{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.chaos.kernel;
in
{
  options.chaos.kernel = {
    enable = mkEnableOption "kernel configuration";

    package = mkOption {
      type = types.attrs;
      default = pkgs.linuxPackages_zen;
      description = "The kernel package to use";
      example = "pkgs.linuxPackages_latest";
    };
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = cfg.package;
  };
}
