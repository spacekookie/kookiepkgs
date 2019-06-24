#!/usr/bin/env bash

nix-shell -p nix-prefetch-github --run "nix-prefetch-github --rev master spacekookie website > pkgs/spacekookie-de/meta.json"
