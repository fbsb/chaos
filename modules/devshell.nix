{
  ...
}:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        name = "chaotic";
        packages = with pkgs; [
          just
          nixos-rebuild
          mkpasswd
        ];
      };
    };
}
