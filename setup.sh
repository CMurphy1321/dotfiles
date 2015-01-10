#!/bin/bash
dir=$HOME/dotfiles
home_dir=$HOME/

# Remove current instances of config files
rm -rf $HOME/.vim
rm -f $HOME/.vimrc
rm -f $HOME/.bashrc
rm -f $HOME/.inputrc
rm -f $HOME/.ssh/config
rm -f $HOME/.ssh/authorized_keys

# Link config files
mkdir -p $HOME/.ssh/
ln -s $dir/vim $HOME/.vim
ln -s $dir/ssh/config $HOME/.ssh/config
ln -s $dir/ssh/authorized_keys $HOME/.ssh/authorized_keys
ln -s $dir/vimrc $HOME/.vimrc
ln -s $dir/bashrc $HOME/.bashrc
ln -s $dir/inputrc $HOME/.inputrc

# Pull in submodules
git submodule init && git submodule update
git submodule update --init --recursive

# Compile YCM
mkdir -p $HOME/ycmbuild && cd $HOME/ycmbuild
cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp || pass="failed"
if [[ "$pass" = "failed" ]]; then
    echo "cmake failed! Please make sure you have cmake installed."
    exit
fi
make ycm_support_libs -j4
rm -rf $HOME/ycmbuild

# Make ssh key if there isn't one
if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa || pass="failed"
    cat ~/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
else
    echo "Existing ssh keys detected. Make sure yours is in the authorized_keys folder to ensure easy sshing!"
fi

# Check to make sure ssh-keygen ran, not applicable most of the time
if [[ "$pass" = "failed" ]]; then
    echo "ssh-keygen failed! Please make sure you have ssh installed."
    exit
fi
