{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.chaos.hardware.nvidia;
in
{
  options.chaos.hardware.nvidia = {
    enable = mkEnableOption "NVIDIA hardware support";
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    };

    boot.blacklistedKernelModules = [ "nouveau" ];

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
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
      nvtopPackages.full
    ];
  };
}
