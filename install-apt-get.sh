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
    neovim
    # ripgrep
)

for pkg in "${packages[@]}"; do
    sudo apt-get -y install $pkg
done
