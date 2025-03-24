{
  disk,
  luks_size ? "100%",
  swap_size ? "8G",
  ...
}:
let
  defaultMountOptions = [
    "defaults"
    "noatime"
    "ssd"
    "discard=async"
    "compress=zstd"
  ];
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = disk;
        content = {
          type = "gpt";
          partitions = {
            part_00_ESP = {
              size = "1G";
              type = "EF00";
              label = "ESP";
              name = "ESP";
              start = "2048";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            };
            part_01_luks = {
              name = "luks";
              size = "${luks_size}";
              label = "ssd_crypted";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ ];
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "ssd";
                };
              };
            };
            # part_02_windows = {
            # };
          };
        };
      };
    };

    lvm_vg = {
      ssd = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "${swap_size}";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true; # resume from hiberation from this device
            };
          };
          system = {
            # size = "15G";
            size = "100%";
            content = {
              type = "btrfs";
              subvolumes = {
                "@" = {
                  mountpoint = "/";
                  mountOptions = defaultMountOptions;
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = defaultMountOptions;
                };
                # "@log" = {
                #   mountpoint = "/var/log";
                #   mountOptions = defaultMountOptions;
                # };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = defaultMountOptions;
                };
                "@persistent" = {
                  mountpoint = "/persistent";
                  mountOptions = defaultMountOptions;
                };
              };
            };
          };
        };
      };
    };
  };

}
