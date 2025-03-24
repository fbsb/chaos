# vms

## start a qemu vm

This will build and run a qemu vm. Note this vm will skip the bootloader and will boot into nixos directly.

This is useful for some quick tests that are not related to disk or bootloader configuration e.g. when testing programs, desktops, etc.

```
nix run -v .#vmConfigurations.test
```
