{
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
{
  ## defaults
  # boot.initrd.availableKernelModules = [
  #   "xhci_pci"
  #   "ahci"
  #   "nvme"
  #   "sr_mod"
  # ];
  # boot.initrd.kernelModules = [ "dm-snapshot" ];
  # boot.kernelModules = [ "kvm-amd" ];
  # boot.extraModulePackages = [ ];

  chaos = {
    desktop.gnome.enable = true;

    shell.zsh = {
      enable = true;
      defaultShell = true;
    };

    system.boot = {
      enable = true;
      type = "systemd";
    };

    services.flatpak.enable = true;

    users.users = {
      chaos = {
        description = "Chaos Test";
        # generate with
        # $ nix-shell -p mkpasswd --run 'mkpasswd -m SHA-512 -s'
        # $ nix run nixpkgs#mkpasswd -- -m SHA-512 -s
        hashedPassword = "$6$ZJqBzixcFY4Xouxk$OtmRe/Rco6mjBBN5nNj5VZ//XhQelP/F6wXncfH6mFyGD4hDHN/RExeE8c5QBPlSfOY6Swerxd8ov8lIcgdqF1"; # testtest
      };
    };
  };

  environment.systemPackages = with pkgs; [ htop ];

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

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
  system.stateVersion = mkForce "24.11"; # Did you read the comment?
}
