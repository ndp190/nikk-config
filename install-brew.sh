#!/bin/bash

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# EDIT HERE for brew packages to install
packages=(
    htop
    kubectl
    node
	python
    autojump
    watch
    lynx
    newsboat
    nvim
	ranger
)
packages_cask=(
    karabiner-elements
)

for pkg in "${packages[@]}"; do
    if brew ls --versions $pkg > /dev/null; then
        brew install $pkg
        echo "[nikk] Package '$pkg' is installed"
    else
        echo "[nikk] Package '$pkg' is not installed"
    fi
done

for pkg in "${packages_cask[@]}"; do
    if brew ls --cask --versions $pkg > /dev/null; then
        brew install --cask $pkg
        echo "[nikk] Package '$pkg' is installed"
    else
        echo "[nikk] Package '$pkg' is not installed"
    fi
done

