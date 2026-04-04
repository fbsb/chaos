{
  den,
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

  den.aspects.tars.includes = [
    (<chaos/system/disko> {
      device = "/dev/nvme0n1";
      swapSize = "72G";
    })
    <chaos/hardware/workstation>
    <chaos/system/keymap/colemak>
    <chaos/desktop/gnome>
  ];

  den.aspects.case.includes = [
    (<chaos/system/disko> {
      device = "/dev/nvme0n1";
      swapSize = "32G";
    })
    <chaos/hardware/framework-13-amd-ai-300>
    <chaos/system/keymap/en-us-intl>
    <chaos/desktop/gnome>
  ];

  den.aspects.fbsb.includes = [
    <chaos/common>
    <den/primary-user>
    <chaos/shell/zsh>
    <chaos/apps/all>
    <chaos/virtualisation/vmware>
  ];

  den.default.includes = [
    <chaos/build-vm>
    <my/state-version>
    <chaos/system/unfree>
  ];
}
