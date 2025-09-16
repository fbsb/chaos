{
  chaosLib,
  ...
}:
let
  chaosModules = chaosLib.modules.findIn ./chaos;
in
{
  imports = chaosModules;
}
