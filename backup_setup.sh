#!/bin/bash
dir=$HOME/dotfiles
backup=$HOME/.dotfiles.bak
home_dir=$HOME/
mkdir -p $backup
mkdir -p $HOME/.ssh

# Backup existing rc files
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

# Link rc files
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

# Backup .vim and .ssh if they exist
# if [ -f $HOME/.vim ]; then
# if [ -f README.md ]; then
#     mv $HOME/.vim $backup/
#     mv $HOME/.ssh $backup/
# fi

if [ -d "$HOME/.vim" ]; then
    echo "Backing up vim folder"
    mv $HOME/.vim $backup/
fi

if [ -d "$HOME/.ssh" ]; then
    echo "Backing up ssh folder"
    mv $HOME/.ssh $backup/
fi

# Link .vim and .ssh folder
ln -s $dir/vim $HOME/.vim
ln -s $dir/ssh $HOME/.ssh

# # Pull in submodules
# git submodule init && git submodule update
# git submodule update --init --recursive
#
# # Compile YCM
# mkdir -p $HOME/ycmbuild && cd $HOME/ycmbuild
# cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp || pass="failed"
# if [[ "$pass" = "failed" ]]; then
#     echo "cmake failed! Please make sure you have cmake installed."
#     exit
# fi
# make ycm_support_libs -j4
# rm -rf $HOME/ycmbuild
#
# If there is no ssh key, make one and add it to 
if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa || pass="failed"
    cat ~/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
else
    echo "Existing ssh keys detected. Make sure yours is in the authorized_keys folder to ensure easy sshing!"
fi
if [[ "$pass" = "failed" ]]; then
    echo "ssh-keygen failed! Please make sure you have ssh installed."
    exit
fi
