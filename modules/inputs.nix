# This repo was generated with github:vic/flake-file#dendritic template.
# Run `nix run .#write-flake` after changing any input.
#
# Inputs can be placed in any module, the best practice is to have them
# as close as possible to their actual usage.
# See: https://vic.github.io/dendrix/Dendritic.html#minimal-and-focused-flakenix
#
# For our template, we enable home-manager and nix-darwin by default, but
# you are free to remove them if not being used by you.
{
  ...
}:
{

  flake-file.inputs = {
    nixpkgs = {
      # url = "github:NixOS/nixpkgs/nixos-25.11";
      url = "github:NixOS/nixpkgs";
    };

    home-manager = {
      # url = "github:nix-community/home-manager/release-25.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

}
