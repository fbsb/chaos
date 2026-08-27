let
  nhModule = {
    perSystem = { pkgs, ... }: {
      apps.nh = {
        type = "app";
        program = pkgs.writeShellApplication {
          name = "nh";
          runtimeInputs = [ pkgs.nh ];
          text = ''
            set -euo pipefail
            if (( $# == 0 )); then
              echo "usage: nix run .#nh -- <command> <build-verb> [nh arguments...]" >&2
              exit 2
            fi

            use_overrides=true
            args=()
            for arg in "$@"; do
              if [[ "$arg" == "--no-overrides" ]]; then
                use_overrides=false
              else
                args+=("$arg")
              fi
            done

            override_args=()
            overrides_dir=".overrides"
            if [[ "$use_overrides" == true && -d "$overrides_dir" ]]; then
              for override in "$overrides_dir"/*; do
                if [[ -d "$override" || -L "$override" ]]; then
                  override_args+=(--override-input "''${override##*/}" "$override")
                fi
              done
            fi

            exec nh "''${args[@]}" . "''${override_args[@]}"
          '';
        };
      };
    };
  };
in
{
  flake.modules.flake.nh = nhModule;

  imports = [
    nhModule
  ];
}
