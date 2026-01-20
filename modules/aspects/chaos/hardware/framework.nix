{
  __findFile ? __findFile,
  ...
}:
{
  chaos.hardware.provides.framework-13-amd-ai-300 = {
    includes = [
      <chaos/hardware/amd>
      <chaos/hardware/fingerprint>
      <chaos/hardware/sensors>
      <chaos/hardware/framework/wifi-quirks>
    ];
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
