{
  chaotic.src = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          # TODO: move to pkgs via an overlay
          (pkgs.callPackage ./_package.nix { })
        ];
      };
  };
}
