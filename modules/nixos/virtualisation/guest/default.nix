{
  config,
  lib,
  virtual ? false,
  namespace,
  ...
}:

with lib;

let
  cfg = config.${namespace}.virtualisation.guest;
in
{
  options.${namespace}.virtualisation.guest = {
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

    ${namespace}.users.extraGroups = [ "vboxsf" ];

    # Additional helpful settings for VMs
    services.spice-vdagentd.enable = mkIf config.services.xserver.enable true;
  };
}
