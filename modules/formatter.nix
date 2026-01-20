{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      formatter = pkgs.nixfmt;
    };

  # Override flake-file's default formatter to avoid nixfmt-rfc-style warning
  flake-file.formatter = pkgs: pkgs.nixfmt;
}
