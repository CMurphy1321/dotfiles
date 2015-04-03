#!/bin/bash
setupdir=$(dirname $0)
cd $setupdir
cd ..
dir=$(pwd)

# Remove current instances of config files
rm -rf $HOME/.vim
rm -f $HOME/.vimrc
rm -f $HOME/.bashrc
rm -f $HOME/.inputrc
rm -f $HOME/.ssh/config
ln -s $dir/config/ssh/config $HOME/.ssh/config

# Link config files
ln -s $dir/config/vim $HOME/.vim
ln -s $dir/config/vimrc $HOME/.vimrc
ln -s $dir/config/bashrc $HOME/.bashrc
ln -s $dir/config/inputrc $HOME/.inputrc

# Pull in submodules
cd $dir/
git submodule init && git submodule update
git submodule update --init --recursive

#Check to see if YCM is compiled
if [ ! -f $dir/config/vim/bundle/YouCompleteMe/python/ycm/youcompleteme.pyc ]; then

# Compile YCM
    mkdir -p $HOME/ycmbuild && cd $HOME/ycmbuild

    cmake --help > cmake_check || not_installed+="\tcmake\n"

    if [ "$not_installed" = "" ]; then
        cmake -G "Unix Makefiles" .  $dir/config/vim/bundle/YouCompleteMe/third_party/ycmd/cpp || pass="failed"
            if [ "$pass" = "failed" ]; then
                clear
                echo "Compiling YCM has failed! Please make sure you have python-dev and build-essential installed and try again. If you have persisting issues, consult https://github.com/Valloric/YouCompleteMe."
                exit
            fi
        #cores=$(grep -c ^processor /proc/cpuinfo)
        #make ycm_support_libs -j$(cores)
        make ycm_support_libs -j4

        clear
        echo "All done! Enjoy :)"
    else
        clear
        echo "The following items are not installed and are required to compile YouCompleteMe. Please install them and try again."
        printf "$not_installed"
    fi

    rm -rf $HOME/ycmbuild/
else
    clear
    echo "All done! Enjoy :)"
fi

if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa || pass="failed"
else
    echo "Existing ssh keys detected. Make sure yours is in the authorized_keys folder to ensure easy sshing!"
fi

if [[ "$pass" = "failed" ]]; then
    echo "ssh-keygen failed! Please make sure you have ssh installed."
    exit
fi
