{
  lib,
  ...
}:
{
  chaos.base = {
    nixos =
      { pkgs, ... }:
      {
        programs.partition-manager.enable = lib.mkDefault true;

        environment.systemPackages = with pkgs; [
          age
          btrfs-progs
          dasel
          disko
          git
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
          psmisc
          vim
          neovim
          tio
        ];
      };
  };
}
