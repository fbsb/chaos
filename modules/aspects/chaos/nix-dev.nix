{
  chaos.nix-dev = {
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
