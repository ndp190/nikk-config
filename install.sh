#!/bin/bash

echo "--NIKK CONFIGURATION INSTALL WIZARD--"
echo

# install vim
read -p "This will install vim config and replace current $HOME/.vim $HOME/.vimrc. Do you want to continue? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -d $HOME/.vim ]; then
        rm -rf $HOME/.vim
    fi
    if [ -L $HOME/.vim ]; then
        unlink $HOME/.vim
    fi

    if [ -f $HOME/.vimrc ]; then
        rm $HOME/.vimrc
    fi
    if [ -L $HOME/.vimrc ]; then
        unlink $HOME/.vimrc
    fi
    
    cp -r vim/.vim $HOME/.vim
    cp vim/.vimrc $HOME/.vimrc
    vim +PluginInstall +qall
fi

echo "--WIZARD COMPLETE--"
echo
