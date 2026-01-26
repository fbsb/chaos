{
  __findFile ? __findFile,
  ...
}:
let
  users = {
    fbsb = {
      description = "Fabian Sabau";
      gitEmail = "git@fbsb.dev";
      # nix run nixpkgs#mkpasswd -- -m scrypt
      passwordHash = "$7$CU..../....YeOtHgY4msMgJPCPkb4Qw/$/5T9x1RVcartjx0TjeHBwmdLwMVQuHcDHU46LUbtAq8";
    };
  };
in
{
  den.hosts.x86_64-linux.tars.users = users;
  den.hosts.x86_64-linux.case.users = users;

  den.homes.x86_64-linux.fbsb = { };

  den.aspects.tars.includes = [
    (<chaos/disko> {
      device = "/dev/nvme0n1";
      swapSize = "72G";
    })
    <chaos/grub>
    <chaos/plymouth>
    <chaos/base>
    <chaos/unfree>
    <chaos/desktop/gnome>
    <chaos/hardware/workstation>
    <chaos/colemak>
    <chaos/berlin>
    <chaos/network>
    <chaos/flatpak>
    <chaos/goxlr>
    <chaos/junction>
    <chaos/zen-browser>
    <chaos/ghostty>
    <chaos/vscode>
    <chaos/gpg>
    <chaos/git>
    <chaos/nix-dev>
    <chaos/src>
  ];

  den.aspects.case.includes = [
    (<chaos/disko> {
      device = "/dev/nvme0n1";
      swapSize = "32G";
    })
    <chaos/grub>
    <chaos/plymouth>
    <chaos/base>
    <chaos/unfree>
    <chaos/desktop/gnome>
    <chaos/hardware/framework-13-amd-ai-300>
    <chaos/laptop>
    <chaos/en-us-intl>
    <chaos/berlin>
    <chaos/network>
    <chaos/flatpak>
    <chaos/goxlr>
    <chaos/junction>
    <chaos/zen-browser>
    <chaos/ghostty>
    <chaos/vscode>
    <chaos/gpg>
    <chaos/git>
    <chaos/nix-dev>
    <chaos/src>
  ];

  den.aspects.fbsb.includes = [
    <den/primary-user>
    <chaos/zsh>
  ];

  den.default.includes = [
    <chaos/defaults>
    <chaos/build-vm>
    <my/state-version>
  ];
}
