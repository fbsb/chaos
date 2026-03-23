{
  __findFile ? __findFile,
  den,
  ...
}:
{
  chaos.common = den.lib.parametric {
    includes = [
      <chaos/cli/git>
      <chaos/cli/gpg>
      <chaos/cli/nix-utils>
      <chaos/dev/nix-dev>
      <chaos/dev/src>
      <chaos/shell/starship>
      <chaos/system/boot/graphical>
      <chaos/system/boot/grub>
      <chaos/system/flatpak>
      <chaos/system/hostname>
      <chaos/system/locale/de-berlin>
      <chaos/system/network>
      <chaos/system/nix-settings>
      <chaos/system/pipewire>
      <chaos/system/unfree>
      <chaos/system/users>
      <chaos/system/utils>
      <den/define-user>
      <den/home-manager>
    ];
  };
}
