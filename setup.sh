#!/bin/bash
dir=$HOME/dotfiles
backup=$HOME/.dotfiles.bak
home_dir=$HOME/

mkdir -p $backup

for file in $home_dir/.*
do
    filename=$(basename $file)
    if [[ "$filename" != "$(basename $0)" ]]; then
        if [[ "$filename" = ".inputrc" || "$filename" = ".vimrc" || "$filename" = ".bashrc" ]]; then
            #|| "$filename" = ".vim" ]]; then
            echo "Backing up .$filename"
            mv $HOME/$filename $backup/
        fi
    fi
done

for file in $dir/*
do
    filename=$(basename $file)
    if [[ "$filename" != "$(basename $0)" ]]; then
        if [[ "$filename" = ".inputrc" || "$filename" = ".vimrc" || "$filename" = ".bashrc" ]]; then
            #|| "$filename" = ".vim" ]]; then
            ln -s $dir/$filename $HOME/.$filename
        fi
    fi
done

# Pull in submodules
git submodule init && git submodule update
cd ~/dotfiles/vim/bundle/YouCompleteMe
git submodule update --init --recursive
mkdir ~/ycmbuild && cd ~/ycmbuild
cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs
rm -rf ~/ycmbuild
