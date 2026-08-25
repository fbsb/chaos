{ chaotic, ... }: {
  chaotic.starship = {
    includes = [
      chaotic.nerd-fonts
    ];
    homeManager = {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        settings = {
          format = [
            "$all"
            "$kubernetes"
          ];
          add_newline = true;
          kubernetes = {
            disabled = false;
          };
          git_status = {
            stashed = "";
          };
        };
      };
    };
  };
}
