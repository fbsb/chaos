{
  inputs,
  ...
}:

final: prev: {
  home-manager = inputs.home-manager.packages.${final.system}.home-manager;
}
