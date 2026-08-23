{
  chaotic.zsh = {
    homeManager = { config, pkgs, ... }: {
      programs.zsh = {
        enable = true;
        autocd = true;

        dotDir = "${config.xdg.configHome}/zsh";

        enableCompletion = true;
        enableVteIntegration = true;

        history = {
          path = "${config.xdg.dataHome}/zsh/zsh_history";

          append = true;
          share = true;
          extended = true;
          expireDuplicatesFirst = true;
          ignoreDups = true;
          ignoreSpace = true;

          save = 1000000;
          size = 1000000;
        };

        autosuggestion = {
          enable = true;
          strategy = [
            "history"
            "completion"
          ];
        };

        plugins = [
          {
            name = "zsh-command-time";
            src = pkgs.zsh-command-time;
          }
          {
            name = "zsh-you-should-use";
            src = pkgs.zsh-you-should-use;
          }
        ];
      };
    };
  };
}
