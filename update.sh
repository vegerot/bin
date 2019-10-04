#!/usr/bin/env bash
echo "brew upgrade"
brew outdated||\
    brew update&&\
    read -p 'Would you like to upgrade Brew (y/n): ' upgradeBrew
if [[ "$upgradeBrew" == "y" ]]; then
    brew upgrade
fi

echo 
echo "vim"

vim +PluginUpdate +qall

echo 
echo "conda update conda"
conda update conda
echo "conda update anaconda"
conda update anaconda
echo 
echo "conda update conda"
conda update conda
echo "conda update anaconda"
conda update anaconda
echo 
echo "conda update --all"
conda update --all
echo "conda update -n astroconda3 --all"
conda update -n astroconda3 --all

echo
echo "softwareupdate -l"
softwareupdate -l
read -p 'Would you like to upgrade macOS (y/n): ' upgradeMacOS
if [[ "$upgradeMacOS" == "y" ]]; then
    softwareupdate -i -a --verbose
fi


echo "App Store"
#open "macappstore://showUpdatesPage"
mas outdated
read -p 'Would you like to upgrade apps?  (y/n): ' upgradeApps
if [[ "$upgradeApps" == "y" ]]; then
    mas upgrade
fi
