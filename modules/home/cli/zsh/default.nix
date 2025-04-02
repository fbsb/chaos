{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.${namespace}.cli.zsh;
in
{
  options.${namespace}.cli.zsh = {
    enable = mkEnableOption "Zsh configuration";
    omzExtraPlugins = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Extra plugins for Oh My Zsh";
      example = [
        "docker"
        "kubectl"
        "helm"
      ];
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autocd = true;

      dotDir = ".config/zsh";

      enableCompletion = true;
      enableVteIntegration = true;

      history = {
        share = true;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
        extended = true;
        save = 100000;
        size = 100000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
      };

      sessionVariables = {
        LC_ALL = "en_US.UTF-8";
      };

      plugins = [
        {
          name = "zsh-autosuggestions";
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
          src = pkgs.zsh-autosuggestions;
        }
        {
          name = "zsh-command-time";
          src = pkgs.zsh-command-time;
        }
        {
          name = "zsh-you-should-use";
          src = pkgs.zsh-you-should-use;
        }
      ];

      # TODO: replace omz with something "better"
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "history"
        ] ++ cfg.omzExtraPlugins;
      };
    };

  };
}
