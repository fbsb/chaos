{
  lib,
  ...
}:
{
  my.state-version = {
    nixos.system.stateVersion = lib.mkDefault "25.11";
    homeManager.home.stateVersion = lib.mkDefault "25.11";
  };
}
