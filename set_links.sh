#!/bin/bash

# This scripts setups links for bashrc and bash_profile
# it backup the previous files (if they are files) and
# create the symlink in place.

# Check file existance and backup
if [ -e "${HOME}/.bashrc" ]; then
   mv ${HOME}/.bashrc ${HOME}/.bashrc.ORIGINAL
   echo "Old .bashrc moved to .bashrc.ORIGINAL"
fi

if [ -e "${HOME}/.bash_profile" ]; then
   mv ${HOME}/.bash_profile ${HOME}/.bash_profile.ORIGINAL
   echo "Old .bash_profile moved to .bash_profile.ORIGINAL"
fi

if [ -e "${HOME}/.ssh/config" ]; then
   mv ${HOME}/.ssh/config ${HOME}/.ssh/config.ORIGINAL
   echo "Old ssh config moved to config.ORIGINAL"
fi


# Check and create symlink
if [ ! -h "${HOME}/.bashrc" ]; then
   ln -s ${HOME}/etc/bashrc ${HOME}/.bashrc
   echo "Symlink .bashrc created"
else
   echo "Symlink .bashrc already exist"
fi

if [ ! -h "${HOME}/.bash_profile" ]; then
   ln -s ${HOME}/etc/bash_profile ${HOME}/.bash_profile
   echo "Symlink .bash_profile created"
else
   echo "Symlink .bash_profile already exist"
fi

if [ ! -h "${HOME}/.ssh/config" ]; then
   ln -s ${HOME}/etc/ssh_config ${HOME}/.ssh/config
   echo "Symlink .ssh/config created"
else
   echo "Symlink .ssh/config already exist"
fi

if [ ! -h "${HOME}/.vimrc" ]; then
   ln -s ${HOME}/etc/vimrc ${HOME}/.vimrc
   ln -s ${HOME}/etc/vimrc ${HOME}/.config/nvim/init.vim
   echo "Symlink .vimrc created"
else
   echo "Symlink .vimrc already exist"
fi
