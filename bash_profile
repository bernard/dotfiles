# Personnal .BASH_PROFILE
# Bernard Bolduc - bernardb@gmail.com
# This content is free and was taken from different sources
# and was modified to my taste.

# Identify OS and Machine
export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export OSVERSION=`uname -r`; OSVERSION=`expr "$OSVERSION" : '[^0-9]*\([0-9]*\.[0-9]*\)'`
export MACHINE=`uname -m | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
export PLATFORM="$MACHINE-$OS-$OSVERSION"
# Note, default OS is assumed to be OSX


# Path
if [ "$OS" = "darwin" ] ; then
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH  # OS-X Specific, with MacPorts and MySQL installed
  #export PATH=/opt/local/bin:/opt/local/sbin:$PATH  # OS-X Specific, with MacPorts installed
fi

if [ -d ~/bin ]; then
	export PATH=~/bin:$PATH  # add your bin folder to the path, if you have it.  It's a good place to add all your scripts
fi


# Load in .bashrc
source ~/.bashrc


# Hello Messsage
echo -e "Kernel Information: " `uname -smr`
echo -ne "Uptime: "; uptime
echo -ne "Server time is: "; date


# Setup SSH-AGENT
SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
  eval `$SSHAGENT $SSHAGENTARGS`
  trap "kill $SSH_AGENT_PID" 0
fi

