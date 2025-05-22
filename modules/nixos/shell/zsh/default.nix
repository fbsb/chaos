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
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    users.defaultUserShell = pkgs.zsh;
  };
}
