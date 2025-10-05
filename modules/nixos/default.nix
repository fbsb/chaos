{
  lib,
  ...
}:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    ./chaos.nix
  ];

  config = {
    chaos = mkDefault {
      boot.enable = true;
      boot.loader = "grub";
      desktop.gnome.enable = true;
      hardware.nvidia.enable = false;
      impermanence.enable = true;
      kernel.enable = false;
      localization.enable = true;
      nix.enable = true;
      programs.base-utils.enable = true;
      services.flatpak.enable = true;
      services.goxlr.enable = true;
      shell.zsh.enable = true;
      users.enable = true;
    };
  };
}
