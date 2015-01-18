dotfiles
========
This is my repository for configuration files related to unix. The setup files
are split into config.sh and ssh.sh. The ssh.sh script installs my config file
and does some basic ssh key management. All config files (bashrc, vim, inputrc)
are setup using config.sh. This script will remove current instances of these
config files then link the config files in this repository to the corresponding
places in your home folder. This includes my vim folder which contains my vim
plugins and colorschemes. It will initialize and update the plugin submodules
as well as compile and install YCM for you if it has not been setup already. If
YCM does not get installed properly, please refer to below. Also make sure you
have the following installed on your machine:
cmake

YCM Installation
========
I use the following steps to install YouCompleteMe. You need to compile it but
it isn't too bad; it only takes a few minutes.

cd ~/.vim/bundle/YouCompleteMe/

git submodule update --init --recursive

mkdir ~/ycmbuild && cd ~/ycmbuild

cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

make ycm_support_libs

And that's it! If this didn't work or you would like more information go to
https://github.com/Valloric/YouCompleteMe.
