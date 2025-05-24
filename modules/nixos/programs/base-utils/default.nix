{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.${namespace}.programs.base-utils;
in
{
  options.${namespace}.programs.base-utils = {
    enable = mkEnableOption "base utils";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dasel
      git
      htop
      jq
      tree
      treecat
      yq-go
    ];
  };
}
