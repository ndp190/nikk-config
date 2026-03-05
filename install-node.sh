#!/bin/bash

# EDIT HERE for node packages to install
packages=(
	bash-language-server
	tree-sitter-cli
)

for pkg in "${packages[@]}"; do
    npm list -g | grep $pkg || npm install -g $pkg --no-shrinkwrap
done
