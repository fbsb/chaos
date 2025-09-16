{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkDefault
    mkEnableOption
    mkIf
    ;

  cfg = config.chaos.programs.base-utils;
in
{
  options.chaos.programs.base-utils = {
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
      btop
      htop
      usbutils
      pciutils
      lshw
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
