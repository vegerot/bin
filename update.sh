#!/usr/bin/env bash
set -o xtrace
echo "brew upgrade"
brew outdated||\
    brew update&&\
    read -p 'Would you like to upgrade Brew (y/n): ' upgradeBrew
if [[ "$upgradeBrew" == "y" ]]; then
    brew upgrade
    echo "brew cask upgrade"
    brew cask upgrade
fi

echo 
echo "vim"

nvim +PlugUpdate +CocUpdate +CocUpdateSync +qall

read -p 'Would you like to upgrade Python (y/n): ' upgradePython
if [[ "$upgradePython" == "y" ]]; then
    echo 
    echo "conda update conda"
    conda update conda
    echo
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

    echo "Upgrading pip3"
    pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 -I {} sh -c "echo \"Updating {}\" && pip3 install -U {}"
fi

read -p 'Would you like to upgrade Node and Ruby (y/n): ' upgradeNode
if [[ "$upgradeNode" == "y" ]]; then
   npm outdated
    echo "npm update -g"
    npm install npm@latest -g --force
    npm update -g
    echo "sudo npm update -g --verbose"
    sudo npm update -g --verbose

    echo "gem update --system"
    gem update --system

    echo "sudo gem update"
    sudo gem update
fi

echo "App Store"
# open "macappstore://showUpdatesPage"
mas outdated
read -p 'Would you like to upgrade apps?  (y/n): ' upgradeApps
if [[ "$upgradeApps" == "y" ]]; then
    mas upgrade
fi
echo

echo "softwareupdate -l"
softwareupdate -l
read -p 'Would you like to upgrade macOS (y/n): ' upgradeMacOS
if [[ "$upgradeMacOS" == "y" ]]; then
    softwareupdate -i -a --verbose
fi

set +o xtrace

