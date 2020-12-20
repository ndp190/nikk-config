#!/bin/bash

# EDIT HERE for node packages to install
packages=(
	bitcoin-chart-cli
)

for pkg in "${packages[@]}"; do
    npm list -g | grep $pkg || npm install -g $pkg --no-shrinkwrap
done
