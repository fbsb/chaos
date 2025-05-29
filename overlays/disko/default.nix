{
  inputs,
  ...
}:

final: prev: {
  disko = inputs.disko.packages.${final.system}.disko;
}
