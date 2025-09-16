{ ezHomeModules, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    ./chaos.nix
  ];

  config = {
    chaos = mkDefault {
      apps.ghostty.enable = true;
      apps.zen-browser.enable = true;
      apps.vscode.enable = true;
      apps.junction.enable = true;
      cli.git.enable = true;
      cli.zsh.enable = true;
      crypto.gpg.enable = true;
      services.flatpak.enable = true;
    };
  };
}
