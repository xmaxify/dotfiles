#!/bin/bash

for dir in */; do
  echo "Stow ${dir}"
  stow "${dir%/}"
done

direnv allow ~/.envrc
