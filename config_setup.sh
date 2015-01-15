#!/bin/bash
dir=$HOME/dotfiles
home_dir=$HOME/

# Remove current instances of config files
rm -rf $HOME/.vim
rm -f $HOME/.vimrc
rm -f $HOME/.bashrc
rm -f $HOME/.inputrc

# Link config files
ln -s $dir/vim $HOME/.vim
ln -s $dir/vimrc $HOME/.vimrc
ln -s $dir/bashrc $HOME/.bashrc
ln -s $dir/inputrc $HOME/.inputrc

# Pull in submodules
git submodule init && git submodule update
git submodule update --init --recursive

# Check to see if YCM is compiled
#if [[ ! -f $HOME/dotfiles/vim/bundle/YouCompleteMe/python/ycm/youcompleteme.pyc ]]; then

    # Compile YCM
    mkdir -p $HOME/ycmbuild && cd $HOME/ycmbuild

    if [[ $(ls -R /usr/include/ | grep "Python.h") = "" ]]; then
        not_installed+="\tpython_dev\n"
    fi


    cmake || not_installed+="\tcmake\n"

    if [[ "$not_installed" = "" ]]; then
        cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
        make ycm_support_libs -j4
    else
        clear
        echo "The following items are not installed and are required to compile YouCompleteMe. Please install them and try again."
        printf "$not_installed"
    fi

    rm -rf $HOME/ycmbuild/
# else
#     clear
#     echo "All done! Enjoy :)"
#fi
