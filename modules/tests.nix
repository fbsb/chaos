# Some CI checks to ensure this template always works.
# Feel free to adapt or remove when this repo is yours.
{
  inputs,
  lib,
  ...
}:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      checkCond = name: cond: pkgs.runCommandLocal name { } (if cond then "touch $out" else "");

      # Generate checks for all hosts dynamically
      hostChecks = lib.concatMapAttrs (
        hostName: hostConfig:
        let
          builds = !pkgs.stdenvNoCC.isLinux || builtins.pathExists (hostConfig.config.system.build.toplevel);
          # vmBuilds = !pkgs.stdenvNoCC.isLinux || builtins.pathExists (hostConfig.config.system.build.vm);
          # vmWithBootloaderBuilds =
          #   !pkgs.stdenvNoCC.isLinux || builtins.pathExists (hostConfig.config.system.build.vmWithBootLoader);
        in
        {
          "${hostName} builds" = checkCond "${hostName}-builds" builds;
          # "${hostName} vm builds" = checkCond "${hostName}-vm-builds" vmBuilds;
          # "${hostName} vm-with-bootloader builds" =
          #   checkCond "${hostName}-vm-with-bootloader-builds" vmWithBootloaderBuilds;
        }
      ) inputs.self.nixosConfigurations;
    in
    {
      checks = hostChecks;
    };
}
