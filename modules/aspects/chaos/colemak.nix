{
  chaos.colemak = {
    nixos = {
      services.xserver.xkb = {
        layout = "us,us";
        variant = "colemak,";
        options = "grp:ctrl_shift_bksp_toggle";
      };

      console.keyMap = "colemak";
    };
  };
}
