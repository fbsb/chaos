{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkForce
    mkIf
    ;

  cfg = config.chaos.nix;
in
{
  options.chaos.nix = {
    enable = mkEnableOption "Nix configuration";
  };

  config = mkIf cfg.enable {

    nixpkgs.config.allowUnfree = true;

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
    };

  };
}
