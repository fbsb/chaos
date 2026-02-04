{
  __findFile ? __findFile,
  den,
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
    (<chaos/system/disko> {
      device = "/dev/nvme0n1";
      swapSize = "72G";
    })
    <chaos/system/boot/grub>
    <chaos/system/boot/graphical>
    <chaos/cli/git>
    <chaos/cli/gpg>
    <chaos/dev/nix-dev>
    <chaos/dev/src>
    <chaos/system/flatpak>
    <chaos/system/network>
    <chaos/system/pipewire>
    <chaos/system/unfree>
    <chaos/system/nix-settings>
    <chaos/system/utils>
    <chaos/system/locale/de-berlin>
    <chaos/system/hostname>
    <den/define-user>
    <den/home-manager>
    <chaos/system/users>

    <chaos/hardware/workstation>
    <chaos/system/keymap/colemak>
    <chaos/desktop/gnome>
    <chaos/apps/all>
  ];

  den.aspects.case.includes = [
    (<chaos/system/disko> {
      device = "/dev/nvme0n1";
      swapSize = "32G";
    })
    <chaos/system/boot/grub>
    <chaos/system/boot/graphical>
    <chaos/cli/git>
    <chaos/cli/gpg>
    <chaos/dev/nix-dev>
    <chaos/dev/src>
    <chaos/system/flatpak>
    <chaos/system/network>
    <chaos/system/pipewire>
    <chaos/system/unfree>
    <chaos/system/nix-settings>
    <chaos/system/utils>
    <chaos/system/locale/de-berlin>
    <chaos/system/hostname>
    <den/define-user>
    <den/home-manager>
    <chaos/system/users>

    <chaos/hardware/framework-13-amd-ai-300>
    <chaos/system/keymap/en-us-intl>
    <chaos/desktop/gnome>
    <chaos/apps/all>
  ];

  den.aspects.fbsb.includes = [
    <den/primary-user>
    <chaos/shell/zsh>
  ];

  den.default.includes = [
    <chaos/build-vm>
    <my/state-version>
  ];
}
