{
  config,
  lib,
  namespace,
  ...
}:

with lib;

let
  cfg = config.${namespace}.cli.git;
in
{
  options.${namespace}.cli.git = {
    enable = mkEnableOption "Git";

    userName = mkOption {
      type = types.str;
      description = "Git user name";
      example = "John Doe";
    };

    userEmail = mkOption {
      type = types.str;
      description = "Git user email";
      example = "john.doe@example.com";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      extraConfig = {
        merge = {
          ff = false;
        };
        pull = {
          ff = "only";
        };
        push = {
          default = "current";
        };
        gc = {
          auto = 0;
          reflogExpire = "never";
          pruneExpire = "never";
        };
      };
      aliases = {
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an <%ae> %C(reset)%C(auto)%d%C(reset)'";
        lga = "!git lg --all";
        amend = "commit --amend";
        cherrypick = "cherry-pick";
        cp = "cherry-pick";
      };
    };
    programs.git-credential-oauth = {
      enable = true;
      extraFlags = [
        "cache --timeout 14400"
      ];
    };
  };
}
