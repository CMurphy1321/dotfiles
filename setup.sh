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
            echo "Backing up .$filename"
            mv $HOME/$filename $backup/
        fi
    fi
done

for file in $dir/*
do
    filename=$(basename $file)
    if [[ "$filename" != "$(basename $0)" ]]; then
        if [[ "$filename" = "inputrc" || "$filename" = "vimrc" || "$filename" = "bashrc" ]]; then
            echo "Creating link for .$filename"
            ln -s $dir/$filename $HOME/.$filename
        fi
    fi
done

if [ -f /home/jester/dotfiles/README.md ]; then
    mv $HOME/.vim $backup/
fi
ln -s $dir/vim $HOME/.vim
# Pull in submodules
git submodule init && git submodule update
git submodule update --init --recursive
mkdir ~/ycmbuild && cd ~/ycmbuild
cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs
rm -rf ~/ycmbuild
