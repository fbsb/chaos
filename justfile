check *args='':
    nix flake check {{args}}

clean-vm:
    #!/usr/bin/env bash
    if [ ! -f .keep-vm ]; then
        rm -f -v result *-efi-vars.fd *.qcow2
    fi

boot target="$(hostname -s)" *args='':
    sudo nixos-rebuild boot --flake ".#{{target}}" {{args}}

switch target="$(hostname -s)" *args='':
    sudo nixos-rebuild switch --flake ".#{{target}}" {{args}}

run-vm target="$(hostname -s)" *args='': clean-vm && clean-vm
    $(nixos-rebuild build-vm --flake ".#{{target}}" {{args}}) || true

boot-vm target="$(hostname -s)" *args='': clean-vm && clean-vm
    $(nixos-rebuild build-vm-with-bootloader --flake ".#{{target}}" {{args}}) || true

write-flake:
    nix run .#write-flake

update *args='':
    nix flake update {{args}}
