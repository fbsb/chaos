{
  den,
  ...
}:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.src = pkgs.callPackage ./_package.nix { };

    };

  chaos.src = den.lib.parametric {
    includes = [
      den._.self'
    ];
    homeManager =
      {
        self',
        ...
      }:
      {
        home.packages = with self'.packages; [
          src
        ];
      };
  };
}
