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
              mainKey = if isDarwin then "cmd" else "alt";
              movementKey = if isDarwin then "cmd+alt" else "alt";
            in
            [
              "${mainKey}+t=new_tab"
              "ctrl+shift+x=toggle_split_zoom"
              "${mainKey}+s=new_split:down"
              "${mainKey}+shift+s=new_split:right"
              "ctrl+page_up=next_tab"
              "ctrl+page_down=previous_tab"
              "${movementKey}+up=goto_split:up"
              "${movementKey}+left=goto_split:left"
              "${movementKey}+right=goto_split:right"
              "${movementKey}+down=goto_split:down"
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
