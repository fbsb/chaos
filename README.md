# Chaos

A Nix flake containing NixOS and home-manager configuration for my machines.

⚠️ This is a work in progress, use it at your own risk.

## Overview

This configuration uses the [Dendritic pattern](https://dendrix.oeiuwq.com/Dendritic.html) to organize modules and configuration.

## Structure

- Reusable aspects are organized under the `chaos` namespace
- Configuration modules live in the `modules/` directory
