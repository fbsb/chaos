{
  chaos.dev.provides.nix-dev = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [
          nixfmt
          treefmt
          nixd
        ];
      };
  };
}
