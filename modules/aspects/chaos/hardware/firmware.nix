{
  chaos.hardware.provides.firmware = {
    nixos =
      {
        pkgs,
        ...
      }:
      {
        services.fwupd.enable = true;

        hardware.enableRedistributableFirmware = true;

        hardware.firmware = with pkgs; [
          linux-firmware
        ];
      };
  };
}
