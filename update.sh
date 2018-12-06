#!/usr/bin/env bash

brew update
read -p 'Would you like to upgrade Brew (y/n): ' upgradeBrew
if [[ "$upgradeBrew" == "y" ]]; then
    brew upgrade
fi
conda update conda
conda update anaconda
conda update conda
conda update anaconda
conda update --all
conda update -n astroconda3 --all

softwareupdate -l
read -p 'Would you like to upgrade macOS (y/n): ' upgradeMacOS
if [[ "$upgradeMacOS" == "y" ]]; then
    softwareupdate -i -a
fi
