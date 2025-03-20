{
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.terminator
  ];
  home.stateVersion = "24.11"; # WARN: Changing this might break things. Just leave it.
}
