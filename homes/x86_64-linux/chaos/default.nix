{
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.usbutils
  ];

  chaos = {
    cli.zsh.enable = true;
    cli.git = {
      enable = true;
      userName = "Chaos Test";
      userEmail = "chaos.test@example.com";
    };
    apps.ghostty.enable = true;
    apps.zen-browser.enable = true;
    services.flatpak.enable = true;
    crypto.gpg.enable = true;
  };

  home.stateVersion = "24.11"; # WARN: Changing this might break things. Just leave it.
}
