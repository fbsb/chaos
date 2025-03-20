#!/usr/bin/env bash

set -euo pipefail

reset=false
# Parse command line arguments
for arg in "$@"; do
  case "$arg" in
    --reset)
      reset=true
      break
      ;;
  esac
done

if [ "${reset}" == "true" ]; then
  rm -f result
  rm -fv *.qcow2
fi

git add -N .

nix build -v .#vmConfigurations.test

result/bin/run-test-vm \
  -vga virtio \
  -device usb-host,vendorid=0x1050,productid=0x0407 \
  -m 8192 \
  -smp 8
