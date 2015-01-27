#!/bin/bash
setupdir=$(dirname $0)
cd $setupdir
cd ..
dir=$(pwd)

# Remove current ssh files
rm -f $HOME/.ssh/config
rm -f $HOME/.ssh/authorized_keys

# Link config files
mkdir -p $HOME/.ssh/
ln -s $dir/config/ssh/config $HOME/.ssh/config
ln -s $dir/config/ssh/authorized_keys $HOME/.ssh/authorized_keys

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
