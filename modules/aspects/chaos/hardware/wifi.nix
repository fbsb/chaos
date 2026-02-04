{
  __findFile ? __findFile,
  lib,
  ...
}:
{
  chaos.hardware.provides.wifi = {
    nixos = {
      hardware.enableAllFirmware = lib.mkDefault true;

      networking.networkmanager.wifi.backend = lib.mkDefault "iwd";

      networking.wireless.iwd.settings = {
        General = {
          AddressRandomization = "network";
          EnableNetworkConfiguration = false;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };
}
