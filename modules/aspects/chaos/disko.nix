{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  chaos.disko =
    {
      device,

      bootPartitionSize ? "1G",
      luksPartitionSize ? "100%",
      swapSize ? "8G",

      bootMountOptions ? [
        "defaults"
        "fmask=0022"
        "dmask=0022"
      ],
      btrfsMountOptions ? [
        "defaults"
        "noatime"
        "ssd"
        "discard=async"
        "compress=zstd"
      ],
    }:
    {
      nixos = {
        imports = [
          inputs.disko.nixosModules.disko
        ];

        disko.devices = {
          disk = {
            main = {
              type = "disk";
              device = device;
              content = {
                type = "gpt";
                partitions = {
                  part_00_ESP = {
                    size = bootPartitionSize;
                    type = "EF00";
                    label = "ESP";
                    name = "ESP";
                    start = "2048";
                    content = {
                      type = "filesystem";
                      format = "vfat";
                      mountpoint = "/boot";
                      mountOptions = bootMountOptions;
                    };
                  };
                  part_01_luks = {
                    name = "system_luks";
                    size = luksPartitionSize;
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
                  size = swapSize;
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
                        mountOptions = btrfsMountOptions;
                      };
                      "@nix" = {
                        mountpoint = "/nix";
                        mountOptions = btrfsMountOptions;
                      };
                      "@home" = {
                        mountpoint = "/home";
                        mountOptions = btrfsMountOptions;
                      };
                      "@persistent" = {
                        mountpoint = "/persistent";
                        mountOptions = btrfsMountOptions;
                      };
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
