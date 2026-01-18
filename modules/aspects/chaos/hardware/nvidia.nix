{
  __findFile ? __findFile,
  lib,
  ...
}:
{
  chaos.hardware._.nvidia = {
    nixos =
      {
        pkgs,
        config,
        ...
      }:
      {
        hardware.graphics = {
          enable = true;
          extraPackages = with pkgs; [ nvidia-vaapi-driver ];
        };

        boot.blacklistedKernelModules = [ "nouveau" ];

        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.nvidia = {
          modesetting.enable = true;
          powerManagement.enable = true;
          powerManagement.finegrained = false;
          open = true;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };

        nixpkgs.config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "nvidia-x11"
              "cuda-merged"
              "cuda_cuobjdump"
              "cuda_gdb"
              "cuda_nvcc"
              "cuda_nvdisasm"
              "cuda_nvprune"
              "cuda_cccl"
              "cuda_cudart"
              "cuda_cupti"
              "cuda_cuxxfilt"
              "cuda_nvml_dev"
              "cuda_nvrtc"
              "cuda_nvtx"
              "cuda_profiler_api"
              "cuda_sanitizer_api"
              "libcublas"
              "libcufft"
              "libcurand"
              "libcusolver"
              "libnvjitlink"
              "libcusparse"
              "libnpp"
              "nvidia-settings"
            ];
        };

        environment.systemPackages = with pkgs; [
          nvfancontrol

          # mesa
          mesa

          # vulkan
          vulkan-tools
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer

          # nvtop
          nvtopPackages.nvidia
        ];
      };
  };
}
