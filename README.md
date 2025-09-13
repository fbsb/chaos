# Chaos

## HowTo

### build installer

```
nix build '.#installer'
```

### install

```
disko --flake github:fbsb/chaos#tars --mode format,mount
nixos-install --no-channel-copy --no-root-password --flake github:fbsb/chaos#tars
```

### update / rebuild

```
sudo nixos-rebuild switch --flake github:fbsb/chaos#tars
# if needed reinstall bootloader (when changing the bootloader)
sudo nixos-rebuild switch --install-bootloader --flake github:fbsb/chaos#tars
```
