{
  chaos.installer = {
    nixos =
      {
        modulesPath,
        ...
      }:
      {
        imports = [
          "${toString modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
        ];
      };
  };
}
