{
  __findFile ? __findFile,
  inputs,
  ...
}:
{
  chaos.hardware.provides.framework-13-amd-ai-300 = {
    includes = [
      <chaos/hardware/laptop>
      <chaos/hardware/amd>
      <chaos/hardware/fingerprint>
      <chaos/hardware/sensors>
      <chaos/hardware/wifi>
      <chaos/hardware/framework/wifi-quirks>
    ];
    nixos = {
      imports = [
        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
      ];
    };
  };

  chaos.hardware.provides.framework.provides.wifi-quirks = {
    nixos = {
      networking = {
        networkmanager.wifi = {
          powersave = false;
        };
      };

      # Fix for mt7925e regulatory domain issues
      # Forces the WiFi card to use DE (Germany) regulatory domain
      boot.extraModprobeConfig = ''
        options cfg80211 ieee80211_regdom=DE
      '';
    };
  };
}
