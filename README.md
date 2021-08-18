dotfiles
========
This is my repository for configuration files related to unix. Running make will remove current instances of various configuration files then link the corresponding files in this repository to your home folder. This includes my vim folder which contains my vim plugins and colorschemes. It will initialize and update the vim plugin submodules as well as compile and install YCM for you. If YCM does not get installed properly, please refer to below.

The lite branch is aimed to be more friendly to remote servers which may have limited or outdated resources. If you notice any issues, feel free to submit them.

> YCM Installation
> ========
> I use the following steps to install YouCompleteMe. You need to compile it but
> it isn't too bad; it only takes a few minutes.

> cd ~/.vim/bundle/YouCompleteMe/

> git submodule update --init --recursive

> mkdir ~/ycmbuild && cd ~/ycmbuild

> cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

> make ycm_support_libs

And that's it! If this didn't work or you would like more information go to
https://github.com/Valloric/YouCompleteMe.
