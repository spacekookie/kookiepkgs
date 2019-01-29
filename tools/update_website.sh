#!/bin/env execlineb

nix-shell -p nix-prefetch-github --run "nix-prefetch-github spacekookie website > pkgs/spacekookie-de/meta.json"
