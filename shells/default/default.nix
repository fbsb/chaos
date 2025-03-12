{
  pkgs,
  namespace,
  ...
}:
pkgs.mkShell {

  name = "${namespace}";
  NIX_CONFIG = "extra-experimental-features = nix-command flakes";

  shellHook = ''
    export SHELL=${pkgs.zsh}/bin/zsh
    exec $SHELL
  '';

  packages = with pkgs; [
    git
    nixos-rebuild
    nixfmt-rfc-style
    nixos-generators
  ];
}
