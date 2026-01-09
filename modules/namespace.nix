{
  inputs,
  den,
  ...
}:
{
  # create an `eg` (example!) namespace. (flake exposed)
  imports = [
    # shared aspects
    (inputs.den.namespace "chaos" true)

    # private aspects
    (inputs.den.namespace "my" false)
  ];

  # this line enables den angle brackets syntax in modules.
  _module.args.__findFile = den.lib.__findFile;
}
