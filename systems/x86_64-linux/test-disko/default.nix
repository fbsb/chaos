{
  ...
}:
{
  imports = [
    ../test
  ];

  chaos = {
    disko = {
      enable = true;
      device = "/dev/sda";
      luksPartitionSize = "100%";
      swapSize = "8G";
    };
    virtualisation.guest.enable = true;
  };
}
