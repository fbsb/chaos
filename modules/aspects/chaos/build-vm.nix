{
  lib,
  ...
}:
{
  chaos.build-vm =
    { user, ... }:
    {
      nixos =
        let
          vmConfig = {
            virtualisation = {
              cores = 4;
              memorySize = 1024 * 8;
              diskSize = 1024 * 50;

              qemu = {
                guestAgent.enable = true;
                options = [
                  "-device virtio-vga-gl"
                  "-display gtk,gl=on,grab-on-hover=off,show-cursor=on,zoom-to-fit=on"
                ];
              };
              fileSystems."/".autoResize = true;
            };

            services.spice-vdagentd.enable = true;
            services.xserver.videoDrivers = [ "modesetting" ];

            users.users.${user.name} = {
              # nix run nixpkgs#mkpasswd -- -m scrypt
              initialHashedPassword = lib.mkForce "$7$CU..../....2kHkjkF7QzRv2Z//2Lf1z/$tJquP.9hv2EzjmigfB6U9257SMa.scXFBwJCNOeVsa7"; # testtest
            };
            boot.growPartition = true;
          };
        in
        {
          virtualisation.vmVariant = vmConfig;
          virtualisation.vmVariantWithBootLoader = vmConfig;
        };
    };
}
