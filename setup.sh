#!/bin/bash
dir=$HOME/dotfiles
backup=$HOME/.dotfiles.bak
home_dir=$HOME/

mkdir -p $backup

for file in $home_dir/.*
do
    filename=$(basename $file)
    if [[ "$filename" != "$(basename $0)" ]]; then
        if [[ "$filename" = ".inputrc" || "$filename" = ".vimrc" || "$filename" = ".bashrc" || "$filename" = ".vim" ]]; then
            echo "Backing up .$filename"
            mv $HOME/$filename $backup/
        fi
    fi
done

for file in $dir/*
do
    filename=$(basename $file)
    if [[ "$filename" != "$(basename $0)" ]]; then
        if [[ "$filename" = "inputrc" || "$filename" = "vimrc" || "$filename" = "bashrc" || "$filename" = "vim" ]]; then
            echo "Creating link for .$filename"
            ln -s $dir/$filename $HOME/.$filename
        fi
    fi
done

# Pull in submodules
git submodule init && git submodule update
