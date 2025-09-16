{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.chaos.dev.nix;
in
{
  options.chaos.dev.nix = {
    enable = mkEnableOption "Enable nix development environment";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixfmt-rfc-style
      treefmt
      nixd
    ];
  };
}
