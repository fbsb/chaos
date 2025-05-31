{
  config,
  lib,
  namespace,
  ...
}:

with lib;

let
  cfg = config.${namespace}.nix;
in
{
  options.${namespace}.nix = {
    enable = mkEnableOption "Nix configuration";
  };

  config = mkIf cfg.enable {

    nix = {
      channel.enable = mkForce false;

      settings = {
        http-connections = 50;
        warn-dirty = false;

        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      optimise = {
        automatic = true;
        dates = [ "04:00" ];
        persistent = true;
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
        persistent = true;
      };

      # flake-utils-plus
      generateNixPathFromInputs = true;
      generateRegistryFromInputs = true;
      linkInputs = true;
    };

  };
}
