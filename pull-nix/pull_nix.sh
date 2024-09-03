#!/usr/bin/env bash
set -eux

nix-channel --update
nix-shell -p nixStatic --run 'cp $(which nix) /app/'
