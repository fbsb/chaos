{
  lib,
  ...
}:
let
  defaultMountOptions = [
    "defaults"
    "noatime"
    "ssd"
    "discard=async"
    "compress=zstd"
  ];
in
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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.systemd-boot.editor = false;
  boot.loader.systemd-boot.rebootForBitlocker = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # networking.hostName = "test-vm";
  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  console.keyMap = "us";

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "us,de,de";
  services.xserver.xkb.variant = "altgr-intl,,bone";
  services.xserver.xkb.options = "grp:ctrl_shift_bksp_toggle";

  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.qemu.guestAgent.enable = true;

  chaos.users.users = {
    fbsb = {
      description = "Fabian Sabau";
      extraGroups = [
        "networkmanager"
      ];
      # generate with
      # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
      hashedPassword = "$6$ZJqBzixcFY4Xouxk$OtmRe/Rco6mjBBN5nNj5VZ//XhQelP/F6wXncfH6mFyGD4hDHN/RExeE8c5QBPlSfOY6Swerxd8ov8lIcgdqF1"; # testtest
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
  system.stateVersion = mkForce "24.11"; # Did you read the comment?
}
