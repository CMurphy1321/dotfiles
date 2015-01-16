#!/bin/bash
dir=$HOME/dotfiles
home_dir=$HOME/

# Remove current instances of config files
rm -rf $HOME/.vim
rm -f $HOME/.vimrc
rm -f $HOME/.bashrc
rm -f $HOME/.inputrc

# Link config files
ln -s $dir/config/vim $HOME/.vim
ln -s $dir/config/vimrc $HOME/.vimrc
ln -s $dir/config/bashrc $HOME/.bashrc
ln -s $dir/config/inputrc $HOME/.inputrc

# Pull in submodules
cd $dir/config
git submodule init && git submodule update
git submodule update --init --recursive

#Check to see if YCM is compiled
if [[ ! -f $HOME/dotfiles/config/vim/bundle/YouCompleteMe/python/ycm/youcompleteme.pyc ]]; then

    # Compile YCM
    mkdir -p $HOME/ycmbuild && cd $HOME/ycmbuild

    #if you're actually reading this you may care about the following:
        #technically you do not need clang in all cases. If you know you do not
        #need clang simply comment the following out.
    clang --help || not_installed+="\tclang\n"

    cmake --help || not_installed+="\tcmake\n"

    if [[ "$not_installed" = "" ]]; then
        cmake -G "Unix Makefiles" . $dir/config/vim/bundle/YouCompleteMe/third_party/ycmd/cpp
        make ycm_support_libs -j4
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
