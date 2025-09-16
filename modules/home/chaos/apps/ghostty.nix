{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.chaos.apps.ghostty;
in
{
  options.chaos.apps.ghostty = {
    enable = mkEnableOption "Ghostty terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      # clearDefaultKeybinds = true;
      settings = {
        keybind = [
          "alt+t=new_tab"
          "ctrl+shift+x=toggle_split_zoom"
          "alt+s=new_split:down"
          "alt+shift+s=new_split:right"
          "ctrl+page_up=next_tab"
          "ctrl+page_down=previous_tab"
          "alt+up=goto_split:up"
          "alt+left=goto_split:left"
          "alt+right=goto_split:right"
          "alt+down=goto_split:down"
        ];
      };
    };
  };

}
