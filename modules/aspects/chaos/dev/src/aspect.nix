{
  den,
  pkgs,
  ...
}:
let
  mkSrc = pkgs: pkgs.callPackage ./_package.nix { };
in
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.src = mkSrc pkgs;
    };

  chaos.dev.provides.src = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = [
          (mkSrc pkgs)
        ];
      };
  };
}
