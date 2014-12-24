#!/bin/bash
dir=$HOME/dotfiles
backup=$HOME/.dotfiles.bak



mkdir -p $backup
for file in $dir/*
do
    filename=$(basename $file)
    if [[ "$filename" = "inputrc" || "$filename" = "vimrc" || "$filename" = "bashrc" || "$filename" = "vim" ]]; then
        echo "Creating link for .$filename"
        # Move existing dotfile to $backup
        mv $HOME/.$filename $backup/
        # Create symlink
        ln -s $dir/$filename $HOME/.$filename
    fi
done

# Pull in # submodules
git submodule init && git submodule update
