# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias open='xdg-open'
alias la='ls -a'
alias ll='ls -l'
PS1='[\u@\h \W]\$ '
. /etc/profile.d/vte.sh

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
