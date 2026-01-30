{
  chaos.unfree = {
    homeManager = {
      nixpkgs.config.allowUnfree = true;
    };
    nixos = {
      nixpkgs.config.allowUnfree = true;
    };
  };
}
