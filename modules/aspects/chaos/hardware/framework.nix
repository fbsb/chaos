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
    ];
  };
}
