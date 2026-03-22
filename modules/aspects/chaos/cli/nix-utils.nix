{
  chaos.cli.provides.nix-utils = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        programs.nix-index = {
          enable = true;
          enableZshIntegration = true;
        };

        home.packages = with pkgs; [
          comma
        ];
      };
  };
}
