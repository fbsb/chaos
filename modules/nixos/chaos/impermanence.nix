{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib)
    mkAfter
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.chaos.impermanence;
  isBtrfs = config.fileSystems."/".fsType == "btrfs";
  rootDevice = config.fileSystems."/".device;
in
{
  imports = [
    inputs.impermanence.nixosModules.default
  ];

  options.chaos.impermanence = {
    enable = mkEnableOption "system impermanence";

    persistentPath = mkOption {
      type = types.str;
      default = "/persistent";
      description = "Path to the persistent storage directory";
    };

    extraDirectories = mkOption {
      type = types.listOf (
        types.either types.str (
          types.submodule {
            options = {
              directory = mkOption {
                type = types.str;
                description = "Path of the directory to make persistent";
              };
              user = mkOption {
                type = types.str;
                default = "root";
                description = "User owning the directory";
              };
              group = mkOption {
                type = types.str;
                default = "root";
                description = "Group owning the directory";
              };
              mode = mkOption {
                type = types.str;
                default = "0755";
                description = "Permissions mode for the directory";
              };
            };
          }
        )
      );
      default = [ ];
      description = "Extra directories to make persistent";
    };

    extraFiles = mkOption {
      type = types.listOf (
        types.either types.str (
          types.submodule {
            options = {
              file = mkOption {
                type = types.str;
                description = "Path of the file to make persistent";
              };
              parentDirectory = mkOption {
                type = types.nullOr (
                  types.submodule {
                    options = {
                      mode = mkOption {
                        type = types.str;
                        default = "0755";
                        description = "Permissions mode for the parent directory";
                      };
                    };
                  }
                );
                default = null;
                description = "Parent directory configuration";
              };
            };
          }
        )
      );
      default = [ ];
      description = "Extra files to make persistent";
    };
  };

  config = mkIf cfg.enable {
    fileSystems."${cfg.persistentPath}".neededForBoot = true;

    boot.initrd.postResumeCommands = mkIf isBtrfs (mkAfter ''
      mkdir /btrfs_tmp
      mount ${rootDevice} -t btrfs -o subvol=/ /btrfs_tmp
      if [[ -e /btrfs_tmp/@ ]]; then
          mkdir -p /btrfs_tmp/@old
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/@ "/btrfs_tmp/@old/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/@old/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/@
      umount /btrfs_tmp
      rm -fr /btrfs_tmp
    '');

    environment.persistence."${cfg.persistentPath}" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ]
      ++ cfg.extraDirectories;
      files = [
        "/etc/machine-id"
      ]
      ++ cfg.extraFiles;
    };
  };
}
