#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-prefetch-github 

nix-prefetch-github --rev master spacekookie website > pkgs/spacekookie-de/meta.json
