{
  ...
}:
let
  disko = import ./disko.nix {
    disk = "/dev/sda";
  };
in
{
  imports = [
    disko
    ../test
  ];

  chaos.virtualisation.guest.enable = true;
}
