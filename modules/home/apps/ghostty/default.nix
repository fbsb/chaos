{
  namespace,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.${namespace}.apps.ghostty;
in
{
  options.${namespace}.apps.ghostty = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Ghostty terminal emulator";
    };
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
          "alt+shift+d=new_split:down"
          "alt+d=new_split:right"
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
