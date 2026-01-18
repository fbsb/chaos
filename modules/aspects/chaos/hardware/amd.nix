{
  __findFile ? __findFile,
  inputs,
  ...
}:
{
  chaos.hardware.provides.amd = {
    includes = [
      <chaos/hardware/firmware>
      <chaos/hardware/amd/cpu>
      <chaos/hardware/amd/gpu>
    ];

    provides.cpu = {
      includes = [
      ];
      nixos = {
        imports = [
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
          inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
        ];
        # TODO check if microcode-amd is still broken
        # hardware.firmware = with pkgs; [
        #   microcode-amd
        # ];
      };
    };

    provides.gpu = {
      includes = [
        inputs.nixos-hardware.nixosModules.common-gpu-amd
      ];
      nixos =
        {
          pkgs,
          ...
        }:
        {
          environment.systemPackages = with pkgs; [
            amdgpu_top
            nvtopPackages.amd
          ];

          hardware.amdgpu = {
            opencl.enable = true;
            initrd.enable = true;
          };
        };
    };
  };
}
