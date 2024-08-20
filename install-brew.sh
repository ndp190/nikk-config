#!/bin/bash

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# EDIT HERE for brew taps to install
taps=(
    homebrew/cask-fonts
)

# EDIT HERE for brew packages to install
packages=(
    tmux
    htop
    watch
    nvim
    # better cd
    zoxide
    # for zoxide 'zi'
    fzf
    gnupg
    # kubectl
    # node
    # python3
    # pyenv
    # autojump
    # lynx
    # newsboat
    # ripgrep
    # go
    # ansible
)
packages_cask=(
    karabiner-elements
    font-hack-nerd-font
)

for pkg in "${taps[@]}"; do
    brew tap $pkg
    echo "[nikk] brew tap '$pkg'"
done

for pkg in "${packages[@]}"; do
    if brew ls --versions $pkg >/dev/null 2>&1; then
        echo "[nikk] Package '$pkg' is already installed"
    else
        brew install $pkg
        echo "[nikk] Package '$pkg' has been installed"
    fi
done

for pkg in "${packages_cask[@]}"; do
    if brew ls --cask --versions $pkg >/dev/null 2>&1; then
        echo "[nikk] Package '$pkg' is already installed"
    else
        brew install --cask $pkg
        echo "[nikk] Package '$pkg' has been installed"
    fi
done

