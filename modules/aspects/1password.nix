{ den, ... }: {
  chaotic._1password = {
    includes = [
      (den.batteries.unfree [
        "1password"
        "1password-cli"
      ])
    ];

    nixos = {
      programs._1password.enable = true;
      programs._1password-gui.enable = true;
    };

    darwin = {
      programs._1password.enable = true;
      programs._1password-gui.enable = true;
    };
  };
}
