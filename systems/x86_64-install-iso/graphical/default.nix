{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

with lib;

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
  ];

  chaos = {
    defaults.enable = false;
    localization.enable = true;
    virtualisation.guest.enable = true;
  };

  isoImage.isoName = mkForce "${config.isoImage.isoBaseName}-${config.system.nixos.release}-${pkgs.stdenv.hostPlatform.system}.iso";
  isoImage.squashfsCompression = "zstd -Xcompression-level 3";

  hardware.enableAllFirmware = true;

  programs.partition-manager.enable = true;

  environment.systemPackages = with pkgs; [
    age
    btrfs-progs
    disko
    git
    home-manager
    htop
    sops
    ssh-to-age
    util-linux
  ];

  services.xserver.desktopManager.gnome = {
    # Add Firefox and other tools useful for installation to the launcher
    favoriteAppsOverride = ''
      [org.gnome.shell]
      favorite-apps=[ 'firefox.desktop', 'nixos-manual.desktop', 'org.gnome.Console.desktop', 'org.gnome.Nautilus.desktop', 'gparted.desktop', 'org.kde.partitionmanager.desktop' ]
    '';

    # Override GNOME defaults to disable GNOME tour and disable suspend
    extraGSettingsOverrides = ''
      [org.gnome.shell]
      welcome-dialog-last-shown-version='9999999999'
      [org.gnome.desktop.session]
      idle-delay=0
      [org.gnome.settings-daemon.plugins.power]
      sleep-inactive-ac-type='nothing'
      sleep-inactive-battery-type='nothing'
    '';

    extraGSettingsOverridePackages = [ pkgs.gnome-settings-daemon ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
