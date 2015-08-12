#!/bin/bash

# This script will create an etc directory in your home_dir in order to be compatible with 
# set_link.sh script.

# Check existance of ${HOME}/etc directory create and copy files
if [ ! -e "${HOME}/etc" ]; then
   echo "Creating ${HOME}/etc/ directory"
   mkdir -p ${HOME}/etc
fi

if [ -e "bashrc" ]; then
  # verify existance of one file in order to copy the content of the setup directory
  echo "Copying files to ${HOME}/etc/"
  cp -rp * ${HOME}/etc/
fi

echo "You can now execute 'set_links.sh' script in order to complete setup"
cd ${HOME}/etc/
