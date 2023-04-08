#!/bin/bash

# EDIT HERE for pip packages to install
packages=(
	# ranger-fm
	pynvim
)

for pkg in "${packages[@]}"; do
	pip3 install $pkg
	echo "[nikk] Package '$pkg' is installed"
done
