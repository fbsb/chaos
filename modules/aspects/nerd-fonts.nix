{
  chaotic.nerd-fonts =
    let
      nerdFontsModule =
        {
          pkgs,
          ...
        }:
        {
          fonts.packages = with pkgs; [
            nerd-fonts.commit-mono
            nerd-fonts.droid-sans-mono
            nerd-fonts.fira-code
            nerd-fonts.hack
            nerd-fonts.noto
            nerd-fonts.ubuntu
          ];
        };
    in
    {
      nixos = nerdFontsModule;
      darwin = nerdFontsModule;
    };
}
