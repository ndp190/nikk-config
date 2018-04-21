#!/bin/bash


if ! git diff-index --quiet HEAD --; then
    git add .
    git commit -m "Auto update commit"
    git push -u origin master
fi
