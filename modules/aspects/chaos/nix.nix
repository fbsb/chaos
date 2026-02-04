{
  lib,
  ...
}:
{
  chaos.nix = {
    nixos.nix = {
      channel.enable = lib.mkForce false;

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
        dates = "daily";
        options = "--delete-older-than 14d";
        persistent = true;
      };
    };
  };
}
