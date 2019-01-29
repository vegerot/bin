#!/usr/bin/env bash

brew outdated||\
    brew update&&\
    read -p 'Would you like to upgrade Brew (y/n): ' upgradeBrew
if [[ "$upgradeBrew" == "y" ]]; then
    brew upgrade
fi

echo 

vim +PluginUpdate +qall

echo 
conda update conda
conda update anaconda
echo 
conda update conda
conda update anaconda
echo 
conda update --all
conda update -n astroconda3 --all

echo

softwareupdate -l
read -p 'Would you like to upgrade macOS (y/n): ' upgradeMacOS
if [[ "$upgradeMacOS" == "y" ]]; then
    softwareupdate -i -a
fi
