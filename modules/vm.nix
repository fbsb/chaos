# enables `nix run .#vm`. it is very useful to have a VM
# you can edit your config and launch the VM to test stuff
# instead of having to reboot each time.
{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      lib,
      system,
      ...
    }:
    {
      packages =
        inputs.self.nixosConfigurations
        |> lib.filterAttrs (_: nixos: nixos.pkgs.system == system)
        |> lib.mapAttrs' (
          name: nixos:
          lib.nameValuePair "${name}-vm" (
            pkgs.writeShellApplication {
              name = "${name}-vm";
              text = ''
                disk_image="''${NIX_DISK_IMAGE:-nixos.qcow2}"
                args=()
                for arg in "$@"; do
                  if [ "$arg" = "--clean" ]; then
                    rm -fv "$disk_image"
                  else
                    args+=("$arg")
                  fi
                done
                ${nixos.config.system.build.vm}/bin/run-${nixos.config.networking.hostName}-vm "''${args[@]}"
              '';
            }
          )
        );
    };
}
