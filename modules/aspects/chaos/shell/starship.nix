{
  chaos.shell.provides.starship = {
    # TODO: move to separate aspect
    nixos =
      {
        pkgs,
        ...
      }:
      {
        fonts.packages = with pkgs; [
          nerd-fonts.commit-mono
          nerd-fonts.droid-sans-mono
          nerd-fonts.fira-code
          nerd-fonts.hack
          nerd-fonts.noto
          nerd-fonts.ubuntu
        ];
      };

    homeManager = {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          add_newline = true;
        };
      };
    };
  };
}
