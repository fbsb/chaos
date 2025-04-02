#!/usr/bin/env bash

set -euo pipefail

# Display usage information
usage() {
    echo "Usage: $(basename "$0") [OPTIONS] TARGET [ARGS...]"
    echo
    echo "Options:"
    echo "  --rebuild       Rebuild the VM image"
    echo "  --reset         Reset the VM state"
    echo "  -h, --help      Display this help message"
    echo
    echo "TARGET: Name of the target VM to run"
    exit 1
}

rebuild=false
reset=false
target=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --rebuild) rebuild=true ;;
        --reset) reset=true ;;
        -h|--help) usage ;;
        -*) echo "Unknown parameter: $1"; usage ;;
        *)
            # First positional argument is the target
            target="$1"
            shift
            break
            ;;
    esac
    shift
done

# Check if target was provided
if [ -z "$target" ]; then
    echo "Error: target argument is required"
    usage
fi

# Reset the VM state if requested
if [ "$reset" = true ]; then
    echo "Resetting VM state for $target..."
    rm -f "${target}.qcow2"
fi

# Define the VM executable path
vm_executable="result/bin/run-${target}-vm"

# Check if rebuild is requested or if the specific VM executable doesn't exist
if [ "$rebuild" = true ] || [ ! -e "$vm_executable" ]; then
    echo "Building VM image for $target..."
    nix build -v ".#vmConfigurations.${target}"
fi

# Run the VM with any remaining arguments
exec "$vm_executable" "$@"
