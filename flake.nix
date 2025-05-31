{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/v1.11.0";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
      };

      homes.modules = with inputs; [
        nix-flatpak.homeManagerModules.nix-flatpak
      ];

      systems.modules.nixos = with inputs; [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        nix-flatpak.nixosModules.nix-flatpak
        impermanence.nixosModules.impermanence
      ];

      snowfall = {
        namespace = "chaos";
        meta = {
          name = "chaos";
          title = "chaos | modular nixos based operating system";
        };
      };
    };
}
