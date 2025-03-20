{
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.usbutils
  ];

  home.stateVersion = "24.11"; # WARN: Changing this might break things. Just leave it.
}
