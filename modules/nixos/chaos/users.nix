{ config
, lib
, inputs
, ...
}:

let
  inherit (lib) mkIf mkOption mkEnableOption types mapAttrs;
  cfg = config.chaos.users;
in
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  options.chaos.users = {
    enable = mkEnableOption "users";

    users = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            description = mkOption {
              type = types.str;
              default = "";
              description = "User description/full name";
            };

            isNormalUser = mkOption {
              type = types.bool;
              default = true;
              description = "Whether this is a normal user account";
            };

            extraGroups = mkOption {
              type = types.listOf types.str;
              default = [ ];
              description = "Groups to add the user to";
            };

            hashedPassword = mkOption {
              type = types.nullOr types.str;
              default = null;
              description = "Hashed password for the user";
            };
          };
        }
      );
      default = { };
      description = "User accounts to create";
    };

    extraGroups = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Groups to add to all users";
    };
  };

  # If any extra groups are specified, map over users.users and append them.
  config = mkIf cfg.enable {
    users.mutableUsers = false;

    users.users = mapAttrs
      (name: user: {
        inherit (user)
          description
          isNormalUser
          ;
        extraGroups = user.extraGroups ++ cfg.extraGroups;
        initialHashedPassword = user.hashedPassword;
      })
      cfg.users;
  };
}
