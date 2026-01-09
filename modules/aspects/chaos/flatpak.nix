{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
  };

  chaos.flatpak = {
    nixos = {
      imports = [
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];

      services.flatpak = {
        enable = true;

        packages = [
          "com.github.tchx84.Flatseal"
        ];

        update.auto = {
          enable = true;
          onCalendar = "daily";
        };

        uninstallUnmanaged = true;
      };
    };
  };
}
