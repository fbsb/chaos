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
    programs.partition-manager.enable = mkDefault true;

    environment.systemPackages = with pkgs; [
      age
      btrfs-progs
      dasel
      disko
      git
      home-manager
      htop
      jq
      sops
      ssh-to-age
      tree
      treecat
      util-linux
      yq-go
    ];
  };
}
