{
  __findFile ? __findFile,
  den,
  ...
}:
{
  chaos.common = den.lib.parametric {
    includes = [
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
    ];
  };
}
