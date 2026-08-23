{
  config,
  lib,
  ...
}:
{
  config.systems =
    config.flake.nixosConfigurations
    |> lib.mapAttrsToList (name: host: host.pkgs.stdenv.hostPlatform.system);
}
