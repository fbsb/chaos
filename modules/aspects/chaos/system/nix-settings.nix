{
  lib,
  ...
}:
let
  caches = {
    substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };
in
{

  flake-file.nixConfig = {
    extra-substituters = caches.substituters;
    extra-trusted-public-keys = caches.trusted-public-keys;
  };

  chaos.system.provides.nix-settings = {
    nixos.nix = {
      channel.enable = lib.mkForce false;

      settings = {
        http-connections = 50;
        warn-dirty = false;

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        trusted-users = [
          "root"
          "@wheel"
        ];

        inherit (caches) substituters trusted-public-keys;

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
