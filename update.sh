#!/usr/bin/env bash

function updateBrew()
{
    echo "brew upgrade"
    brew outdated||\
        brew update&&\
        read -p 'Would you like to upgrade Brew (y/n): ' upgradeBrew
            if [[ "$upgradeBrew" == "y" ]]; then
                brew upgrade
            fi
}

function updateVim()
{
    echo "vim"
    vim +PluginUpdate +qall
}

function updateConda()
{
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
}

function updateMacOS()
{
    echo "softwareupdate -l"
    softwareupdate -l
    read -p 'Would you like to upgrade macOS (y/n): ' upgradeMacOS
    if [[ "$upgradeMacOS" == "y" ]]; then
        softwareupdate -i -a
    fi
}




start=`gdate +%s.%N`

if [[ $1 == "--time" ]]; then
    time updateBrew
    echo
    time updateVim
    echo
    time updateConda
    echo
    time updateMacOS
else
    updateBrew
    echo
    updateVim
    echo
    updateConda
    echo
    updateMacOS
fi
end=`gdate +%s.%N`

run=$(echo "$end - $start"|bc -l)
echo "$run seconds"
