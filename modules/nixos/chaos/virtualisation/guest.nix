{ config
, lib
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkForce
    mkIf
    ;

  cfg = config.chaos.virtualisation.guest;
in
{
  options.chaos.virtualisation.guest = {
    enable = mkEnableOption "vm guest services";
  };

  config = mkIf cfg.enable {
    services.qemuGuest.enable = mkForce true;
    # services.xe-guest-utilities.enable = mkForce true;
    virtualisation.hypervGuest.enable = mkForce true;
    virtualisation.virtualbox.guest.enable = mkForce true;
    virtualisation.vmware.guest.enable = mkForce true;

    chaos.users.extraGroups = [ "vboxsf" ];

    services.spice-vdagentd.enable = mkForce true;
    services.xserver.videoDrivers = [ "vmware" ];
  };
}
