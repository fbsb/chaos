{
  chaos.git =
    {
      user,
      ...
    }:
    {
      homeManager = {
        programs.git = {
          enable = true;
          lfs.enable = true;
          settings = {
            user.name = user.description;
            user.email = user.gitEmail;
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
      };
    };
}
