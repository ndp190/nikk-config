#!/bin/bash

text=$(sed 's/\[0/\\x1B\[0/g' <<< "$1")
text=$(sed 's/\[1/\\x1B\[1/g' <<< "$text")
echo -e "$text"
