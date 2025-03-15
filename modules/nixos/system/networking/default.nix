{
  config,
  lib,
  namespace,
  ...
}:
with lib;
{
  options.${namespace}.networking = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "${namespace} networking configuration";
    };
  };

  config = mkIf config.${namespace}.networking.enable {
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
