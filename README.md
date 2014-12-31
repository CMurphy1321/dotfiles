dotfiles
========
This is my repository for configuration files related to unix. My setup.sh
script will backup current instances of .bashrc, .inputrc, and .vimrc in your
home folder then link the configuration files in this repository to the
corresponding files in your home folder. This includes .vim which contains my
vim plugins and colorschemes. It will also compile and install YCM for you. If
YCM does not get installed properly, please refer to below.

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
