#!/bin/bash

# EDIT HERE for apt packages to install
packages=(
    # htop
    # kubectl
    # node
    # python3
    # pyenv
    # autojump
    # watch
    # lynx
    # newsboat
    nvim
    # ripgrep
)

for pkg in "${packages[@]}"; do
    sudo apt-get install $pkg
done
