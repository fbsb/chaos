{
  lib,
  ...
}:
{
  chaos.hardware.provides.fingerprint = {
    nixos =
      {
        pkgs,
        ...
      }:
      {
        services.fprintd.enable = true;
        services.fprintd.tod.enable = true;
        services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

        nixpkgs.config.allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "libfprint-2-tod1-goodix"
          ];
      };
  };
}
