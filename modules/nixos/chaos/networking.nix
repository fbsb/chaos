{
  config,
  lib,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.chaos.networking;
in
{
  options.chaos.networking = {
    enable = mkEnableOption "system networking";
  };

  config = mkIf cfg.enable {
    # Enable NetworkManager for network configuration
    networking = {
      networkmanager.enable = true;
    };

    # Enable firewall by default with standard configuration
    networking.firewall = {
      enable = true;
      allowPing = true;
    };

    # Ensure DNS resolution works properly
    services.resolved.enable = true;
  };
}
