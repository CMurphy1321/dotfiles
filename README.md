dotfiles
========
This is my repository for configuration files related to unix. My setup.sh
script is a fairly basic one which will backup current instances of .bashrc,
.inputrc, and .vimrc in your folder folder then link the configuration files in
this repository to the corresponding file in your home folder. This includes
.vim which contains my vim plugins and colorschemes.

YCM Installation
========
I use the following steps to install YouCompleteMe. You need to compile it but
it isn't too bad; it only takes a few minutes.

cd ~/.vim/bundle/YouCompleteMe/
git submodule add git@github.com:Valloric/YouCompleteMe.git
./install.sh --clang-completer

And that's it! If this didn't work or you would like more information go to
https://github.com/Valloric/YouCompleteMe.
