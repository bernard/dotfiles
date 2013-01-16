# Personnal .BASHRC
# Bernard Bolduc - bernardb@gmail.com
# This content is free and was taken from different sources
# and was modified to my taste.

if [[ $- == *i* ]] ; then
  export IS_INTERACTIVE=true
else
  export IS_INTERACTIVE=false
fi

if [[ -z $SSH_CONNECTION ]]; then
  export IS_REMOTE=false
else
  export IS_REMOTE=true
fi



# SET Colors
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1 

if [ "$OS" = "linux" ] ; then
  alias ls='ls --color=auto'
  # ls colors, see: http://www.linux-sxs.org/housekeeping/lscolors.html
  export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rb=90'  #LS_COLORS is not supported by the default ls command in OS-X
else
  alias ls='ls -G'  # OS-X SPECIFIC - the -G command in OS-X is for colors, in linux it's no groups
fi



# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'"  # lists all the colors



# History Control
export HISTCONTROL=ignoredups
export HISTFILESIZE=3000
export HISTIGNORE="ls:cd:[bf]g:exit:..:...:ll:lla"
alias h=history
hf(){ 
  grep "$@" ~/.bash_history
}


# Prompt SETUP
if [ $IS_INTERACTIVE = 'true' ] ; then # Interactive shell only

  # Input stuff -------------------------------------------------------
  bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
  bind "set show-all-if-ambiguous On" # show list automatically, without double tab
  bind "set bell-style none" # no bell

  shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

  # Confirgure Prompts

  prompt_func() {
      previous_return_value=$?;
      if [ $IS_REMOTE = 'true' ] ; then
	    # remote shell
	    if [ `/usr/bin/whoami` = "root" ] ; then
			# root has a red prompt
			prompt="\[${COLOR_RED}\]\u@\h \[${COLOR_LIGHT_RED}\]\w \[${COLOR_RED}\]\# \[${COLOR_NC}\] "
		else
		    if [ `hostname` = "d05cy9" -o `hostname` = "pinky" ] ; then
			    prompt="\[${COLOR_LIGHT_GREEN}\]\u@\h \[${COLOR_YELLOW}\]\w \[${COLOR_LIGHT_GREEN}\]\$ \[${COLOR_NC}\] "
			else
			    # unknown host
			    prompt="\[${COLOR_LIGHT_GREEN}\]\u@\h \[${COLOR_YELLOW}\]\w \[${COLOR_LIGHT_GREEN}\]\$ \[${COLOR_NC}\] "
			fi
		fi
      else
	    # local shell
		if [ `/usr/bin/whoami` = "root" ] ; then
			# root has a red prompt
			prompt="\[${COLOR_RED}\]\u@\h \[${COLOR_LIGHT_RED}\]\w \[${COLOR_RED}\]\# \[${COLOR_NC}\] "
		else
		    if [ `hostname` = "d05cy9" -o `hostname` = "pinky" ] ; then
		        prompt="\[${COLOR_LIGHT_BLUE}\]\u@\h \[${COLOR_LIGHT_CYAN}\]\w \[${COLOR_LIGHT_BLUE}\]\$ \[${COLOR_NC}\] "
		    else
		        prompt="\[${COLOR_LIGHT_BLUE}\]\u@\h \[${COLOR_LIGHT_CYAN}\]\w \[${COLOR_LIGHT_BLUE}\]\$ \[${COLOR_NC}\] "
		    fi
		fi
	  fi

      if test $previous_return_value -eq 0
      then
          PS1="${prompt}> "
      else
          PS1="${prompt}\[${COLOR_RED}\]> \[${COLOR_NC}\]"
      fi
  }
  PROMPT_COMMAND=prompt_func

  export PS2='> '    # Secondary prompt
  export PS3='#? '   # Prompt 3
  export PS4='+'     # Prompt 4

  function xtitle {  # change the title of your xterm* window
    unset PROMPT_COMMAND
    echo -ne "\033]0;$1\007" 
  }

fi



# Navigation and Directory HACK
alias ..='cd ..'
alias ...='cd .. ; cd ..'
cl() { cd $1; ls -la; } 

# save directory as tags http://www.macosxhints.com/article.php?story=20020716005123797
# to add a tag:
#     in directory type: 
#     save <tag>
# you can now move to this directory tag by:
#     cd <tag>

if [ ! -f ~/.dirs ]; then  # if doesn't exist, create it
  touch ~/.dirs
fi

alias show='cat ~/.dirs'
save (){
  command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ; 
}  #"
source ~/.dirs  # Initialization for the above 'save' facility: source the .sdirs file 
shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility



# Editors
#export EDITOR='mate -w'  # OS-X SPECIFIC - TextMate, w is to wait for TextMate window to close
export EDITOR='vim'  #Command line

if [ "$OS" = "darwin" ] ; then
  alias v=mvim
  alias vc=vim
  alias vt='mvim --remote-tab'
else
  alias v=vim
fi



# Security
# Notes, hardly used
# Folder shared by a group
# chmod g+s directory 
#find /foo -type f -print | xargs chmod g+rw,o-rwx,u+rw
#find /foo -type d -print | xargs chmod g+rwxs,o-rwx,u+rwx

# this might work just the same (not tested)
# chmod -R g+rwXs,o-rwx,u+rwX /foo


# Other aliases
alias ll='ls -hl'
alias la='ls -a'
alias lla='ls -lah'

# Misc
alias reloadbash='source ~/etc/bash_profile'

alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias m='more'
alias top='top -o cpu' # os x

alias df='df -h' # Show disk usage

if [ "$OS" = "linux" ] ; then
  alias ps_all='ps -AH'
else
  alias ps_all='ps -Afjv'
fi

if [ "$OS" = "linux" ] ; then
  alias systail='tail -f /var/log/messages'
else
  alias systail='tail -f /var/log/system.log'
fi

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

alias untar="tar xvzf"

alias cp_folder="cp -Rpv" #copies folder and all sub files and folders, preserving security and dates

alias mirror_website="wget -m -x -p --convert-links --no-host-directories --no-cache -erobots=off"

killhard() {
    kill -9 "$1"
}


if [ -f ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi



# Test 
#if [ "$OS" = "linux" ] ; then
#elif
#else
#fi

