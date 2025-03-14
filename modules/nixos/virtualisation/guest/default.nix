{
  config,
  lib,
  virtual ? false,
  ...
}:

with lib;

let
  cfg = config.virtualisation.guest;
in
{
  options.virtualisation.guest = {
    enable = mkOption {
      type = types.bool;
      default = virtual;
      description = "Whether to enable guest services for virtual machines.";
    };
  };

  config = mkIf cfg.enable {
    # Enable QEMU guest agent when in a QEMU/KVM VM
    services.qemuGuest.enable = true;

    # Enable VirtualBox guest additions when in a VBox VM
    virtualisation.virtualbox.guest.enable = true;

    # TODO add all users to vboxsf group

    # Additional helpful settings for VMs
    services.spice-vdagentd.enable = mkIf config.services.xserver.enable true;
  };
}
