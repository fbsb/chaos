# install

The examples described here will mount and install nixos to /mnt by default.

## disko

Format and mount the disk with disko. This should not delete any partitions, volumes, etc that are already there and match the disko configuration.

```
disko --flake /chaos#test-disko --mode format,mount
```

To pass arguments e.g. disk to the disko, run in file mode (check disko file for available arguments)

```
disko systems/x86_64-linux/test-disko/disko.nix --mode format,mount  --argstr disk /dev/sda
```

Skip and run latest disko version with

```
nix run 'github:nix-community/disko/latest#disko' --
```

## install nixos

```
nixos-install --no-channel-copy --no-root-password --flake /chaos#test-disko
```

## install with disko (experimental)

***WARNING all data is lost as this erase the disk***

```
disko-install --flake /chaos#test-disko --mode format --disk main /dev/sda
```
## troubleshooting

change parts of the disk e.g. remove a partiton, lvm volume, btrfs subvolume

***WARNING may result in data loss***

```
disko --flake /chaos#test-disko --mode mount

# change disk here

disko --flake /chaos#test-disko --mode format,mount

```

start fresh

***WARNING this will erase all data***

```
disko --flake /chaos#test-disko --mode destroy,format,mount
```
