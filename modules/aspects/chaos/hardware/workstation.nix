{
  __findFile ? __findFile,
  inputs,
  ...
}:
{
  chaos.hardware.provides.workstation = {
    includes = [
      <chaos/hardware/firmware>
      <chaos/hardware/amd/cpu>
      <chaos/hardware/nvidia>
      <chaos/hardware/sensors>
    ];
  };
}
