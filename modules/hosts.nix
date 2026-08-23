# host and user definitions for testing
{ den, chaotic, ... }: {
  # tux user at igloo host.
  den.hosts.x86_64-linux.igloo.users.tux = { };

  # define an standalone home-manager for tux
  den.homes.x86_64-linux.tux = { };

  # be sure to add nix-darwin input for this:
  # den.hosts.aarch64-darwin.apple.users.alice = { };

  den.aspects.igloo = {
    includes = [
      (den.batteries.tty-autologin "tux")
    ];

    nixos = {
      boot.loader.grub.enable = false;
      fileSystems."/".device = "/dev/fake";
      fileSystems."/".fsType = "auto";
    };
  };

  # user aspect
  den.aspects.tux = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")

      # add user aspects here
      chaotic.zsh
      chaotic.bash
      chaotic.git
      chaotic.gpg
      chaotic.ghostty
      chaotic.starship
      chaotic.src
    ];
  };
}
