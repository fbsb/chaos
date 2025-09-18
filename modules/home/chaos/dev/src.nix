{
  config,
  lib,
  self,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.chaos.dev.src;
in
{
  options.chaos.dev.src = {
    enable = mkEnableOption "Enable src tool";
  };

  config = mkIf cfg.enable {
    home.packages = with self.packages.${config.nixpkgs.system}; [
      src
    ];

    # TODO: add shell plugin
  };
}
