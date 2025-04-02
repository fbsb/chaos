{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.${namespace}.shell.zsh;
in
{
  options.${namespace}.shell.zsh = {
    enable = mkEnableOption "ZSH shell";
    defaultShell = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to use ZSH as default shell";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    users.defaultUserShell = pkgs.zsh;
  };
}
