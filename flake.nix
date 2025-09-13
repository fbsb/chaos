{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    ez-configs.url = "github:ehllie/ez-configs";
    ez-configs.inputs.nixpkgs.follows = "nixpkgs";
    ez-configs.inputs.flake-parts.follows = "flake-parts";

    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/v1.11.0";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs@{ self, flake-parts, ez-configs, ... }:
    let
      lib = inputs.nixpkgs.lib;
      chaosLib = import ./lib { inherit lib; };
    in
    flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      {
        imports = [
          ez-configs.flakeModule
        ];

        debug = true;

        # mkFlake expects this to be present,
        # so even if we don't use anything from perSystem, we need to set it to something.
        # You can set it to anything you want if you also want to provide perSystem outputs in your flake.
        systems = [
          "x86_64-linux"
        ];

        perSystem = { system, ... }: {
          packages = {
            installer = inputs.nixos-generators.nixosGenerate {
              inherit system;

              format = "install-iso";
              specialArgs = {
                inherit inputs self chaosLib;
              };
              modules = [
                ./installer
              ];
            };
          };
        };

        ezConfigs = {
          root = ./.;
          globalArgs = {
            inherit inputs chaosLib;
          };

          home.modulesDirectory = ./modules/home;
          home.configurationsDirectory = ./users;

          nixos.modulesDirectory = ./modules/nixos;
          nixos.configurationsDirectory = ./hosts;

          nixos.hosts.tars.userHomeModules = [ "fbsb" ];
        };

        flake = {
          lib = chaosLib;
        };
      };

}
