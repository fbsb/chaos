{
  chaotic.git = { user, host, ... }: {
    homeManager =
      let
        shellAliases = {
          g = "git";
          ga = "git add";
          gb = "git branch";
          gco = "git checkout";
        };
      in
      {
        programs.git = {
          enable = true;
          lfs.enable = true;
          ignores = [
            ".DS_Store"
            "._*"
            ".netrwhist"
            "*.swp"
            "*.swo"
            "*~"
            "Session.vim"
            "Sessionx.vim"
          ];
          settings = {
            user.name = user.gitUser or user.description or user.name;
            user.email = user.gitEmail or user.email or "${user.name}@${host.name or "localhost"}";
            merge = {
              ff = false;
            };
            pull = {
              ff = "only";
            };
            push = {
              default = "current";
            };
            init = {
              defaultBranch = "main";
            };
            gc = {
              auto = 0;
              reflogExpire = "never";
              pruneExpire = "never";
            };
            credential = {
              helper = [
                "cache --timeout 14400"
              ];
            };
            alias = {
              lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an <%ae> %C(reset)%C(auto)%d%C(reset)'";
              lga = "!git lg --all";
              amend = "commit --amend";
              cherrypick = "cherry-pick";
              cp = "cherry-pick";
            };
          };

        };
        programs.git-credential-oauth = {
          enable = true;
        };

        programs.zsh.shellAliases = shellAliases;
        programs.bash.shellAliases = shellAliases;
      };
  };
}
