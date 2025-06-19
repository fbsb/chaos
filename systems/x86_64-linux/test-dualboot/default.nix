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
      luksPartitionSize = "50G";
      swapSize = "16G";
    };
    virtualisation.guest.enable = true;
    boot.loader = "systemd"; # needed for better bitlocker support
  };
}
