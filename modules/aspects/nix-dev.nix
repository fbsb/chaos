{
  chaotic.nix-dev = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nixfmt
          nixd
        ];
      };
  };
}
