{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.chaos.disko;
in
{
  options.chaos.disko = {
    enable = mkEnableOption "disko disk configuration";

    device = mkOption {
      type = types.str;
      description = "The disk device to use (e.g., /dev/sda)";
      example = "/dev/sda";
    };

    bootPartitionSize = mkOption {
      type = types.str;
      default = "1G";
      description = "Size of the boot partition";
      example = "1G";
    };

    luksPartitionSize = mkOption {
      type = types.str;
      default = "100%";
      description = "Size of the LUKS partition (e.g., '100%' for remaining space or '100G' for specific size)";
      example = "100G";
    };

    swapSize = mkOption {
      type = types.str;
      default = "8G";
      description = "Size of the swap volume";
      example = "8G";
    };

    btrfsMountOptions = mkOption {
      type = types.listOf types.str;
      default = [
        "defaults"
        "noatime"
        "ssd"
        "discard=async"
        "compress=zstd"
      ];
      description = "Default mount options for btrfs subvolumes";
      example = [
        "defaults"
        "noatime"
        "ssd"
        "discard=async"
        "compress=zstd"
      ];
    };

    bootMountOptions = mkOption {
      type = types.listOf types.str;
      default = [
        "defaults"
        "fmask=0022"
        "dmask=0022"
      ];
      description = "Mount options for the boot partition (vfat filesystem)";
      example = [
        "defaults"
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  config = mkIf cfg.enable {
    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = cfg.device;
          content = {
            type = "gpt";
            partitions = {
              part_00_ESP = {
                size = cfg.bootPartitionSize;
                type = "EF00";
                label = "ESP";
                name = "ESP";
                start = "2048";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = cfg.bootMountOptions;
                };
              };
              part_01_luks = {
                name = "system_luks";
                size = cfg.luksPartitionSize;
                label = "system_luks";
                content = {
                  type = "luks";
                  name = "system";
                  extraOpenArgs = [ ];
                  settings = {
                    allowDiscards = true;
                  };
                  content = {
                    type = "lvm_pv";
                    vg = "system";
                  };
                };
              };
            };
          };
        };
      };

      lvm_vg = {
        system = {
          type = "lvm_vg";
          lvs = {
            swap = {
              size = cfg.swapSize;
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true; # resume from hibernation from this device
              };
            };
            root = {
              size = "80%";
              content = {
                type = "btrfs";
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = cfg.btrfsMountOptions;
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = cfg.btrfsMountOptions;
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = cfg.btrfsMountOptions;
                  };
                  "@persistent" = {
                    mountpoint = "/persistent";
                    mountOptions = cfg.btrfsMountOptions;
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
