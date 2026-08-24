{
  chaotic.ghostty = {
    homeManager = { pkgs, ... }: {
      programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
        # clearDefaultKeybinds = true;
        settings = {
          keybind =
            let
              isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
              key = if isDarwin then "cmd" else "alt";
            in
            [
              "${key}+t=new_tab"
              "ctrl+shift+x=toggle_split_zoom"
              "${key}+s=new_split:down"
              "${key}+shift+s=new_split:right"
              "ctrl+page_up=next_tab"
              "ctrl+page_down=previous_tab"
              "${key}+up=goto_split:up"
              "${key}+left=goto_split:left"
              "${key}+right=goto_split:right"
              "${key}+down=goto_split:down"
            ];
          theme = "light:Monokai Pro Light,dark:Monokai Pro";
          shell-integration-features = "cursor,no-sudo,title,ssh-env,ssh-terminfo,path";
          tab-inherit-working-directory = false;
          window-inherit-working-directory = false;
        };
      };
    };
  };
}
