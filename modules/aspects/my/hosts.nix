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

  den.homes.x86_64-linux.fbsb = { };

  den.aspects.tars.includes = [
    (<chaos/disko> { device = "/dev/nvme0n1"; })
    <chaos/grub>
    <chaos/plymouth>
    <chaos/base>
    <chaos/gnome>
    <chaos/colemak>
    <chaos/berlin>
    <chaos/network>
    <chaos/nvidia>
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
