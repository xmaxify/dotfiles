#!/bin/bash

cd ~/.dotfiles
for dir in */; do
  echo "Stow ${dir}"
  stow "${dir%/}"
done
