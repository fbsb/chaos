{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.chaos.shell.zsh;
in
{
  options.chaos.shell.zsh = {
    enable = mkEnableOption "ZSH shell";
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    users.defaultUserShell = pkgs.zsh;
  };
}
