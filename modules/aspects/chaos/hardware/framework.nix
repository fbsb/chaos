{
  __findFile ? __findFile,
  inputs,
  ...
}:
{
  chaos.hardware.provides.framework-13-amd-ai-300 = {
    includes = [
      <chaos/hardware/amd>
      <chaos/hardware/fingerprint>
      <chaos/hardware/sensors>
    ];
    nixos = {
      imports = [
        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
        inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
        inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
      ];
    };
  };
}
