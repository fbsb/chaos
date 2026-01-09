{
  __findFile ? __findFile,
  den,
  ...
}:
{
  chaos.defaults = den.lib.parametric {
    includes = [
      <den/define-user>
      <den/home-manager>
      <chaos/hostname>
      <chaos/users>
      <chaos/nix>
    ];
  };
}
