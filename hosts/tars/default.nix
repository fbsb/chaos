{ inputs
, ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  chaos = {
    disko = {
      enable = true;
      device = "/dev/nvme0n1";
      luksPartitionSize = "2T";
      swapSize = "72G";
    };
    
    hardware.nvidia.enable = true;

    users.users = {
      fbsb = {
        description = "Fabian Sabau";
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        # generate with
        # $ nix run nixpkgs#mkpasswd -- -m scrypt
        hashedPassword = "$7$CU..../....AmA1g5gg5cK7GRQ4rs5uS1$di2/tDJ3O2fNgNuYCPHQMUGTvlVV/h8l3pixX40.rU8";
      };
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
