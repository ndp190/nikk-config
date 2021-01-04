#!/bin/bash

for DIR in $(find $1 -type d); do
    touch $DIR/__init__.py
done
