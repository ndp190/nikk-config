#!/bin/bash

if brew ls --cask --versions karabiner-elements > /dev/null; then
    echo "Package '$pkg' is installed"
else
    echo "Package '$pkg' is not installed"
fi
