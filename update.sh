#!/usr/bin/env bash
echo "sudo apt update"
sudo apt update &&\
    read -p 'Would you like to upgrade apt (y/n): ' upgradeApt
if [[ "$upgradeApt" == "y" ]]; then
    sudo apt upgrade
fi

echo 
echo "vim"

nvim +PlugUpdate +CocUpdate +CocUpdateSync +qall

#read -p 'Would you like to upgrade Python (y/n): ' upgradePython
if [[ "$upgradePython" == "y" ]]; then
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
    
    echo "Upgrading pip3"
    pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 -I {} sh -c "echo \"Updating {}\" && pip3 install -U {}"
fi

echo "npm update -g --verbose"
npm outdated
npm install npm -g --force
npm update -g
echo "sudo npm update -g --verbose"
sudo npm update -g --verbose

echo "gem update --system"
gem update --system

echo "sudo gem update"
sudo gem update

echo "sudo apt dist-upgrade"
sudo apt dist-upgrade
