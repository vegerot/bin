start=`date +%s.%N`
set -o vi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

. ~/.git-prompt.sh
PROMPT_COMMAND=__prompt_command
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
__prompt_command()
{
	
	local EXIT="$?"
	PROMPT_DIRTRIM=$((1+$(($(tput cols)/12))))
	PS1=$(check_conda_env)
	local RCol='\[\e[0m\]'
	local Red='\[\e[0;31m\]'
	local Blue='\[\e[0;36m\]'
	if [ $EXIT != 0 ]; then
		PS1+="${Red}\u${Rcol}"
	else
		PS1+="${Blue}\u${Rcol}"
	fi
#	PS1+="\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\n\$ "
	PS1+="\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\033[35m$(__git_ps1)\033[m \n\$ "	

}


check_conda_env ()
{
    if [ ! -z "$CONDA_DEFAULT_ENV" ]; then
        printf -- "%s" "\[\e[0;39m\][`basename $CONDA_DEFAULT_ENV`]\[\e[0m\] "
    else
        printf -- "%s" ""
    fi
}

mkcdir () {
	mkdir -p -- "$1" && cd -P -- "$1"
}


export PS1

#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\n\$ "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
. ~/bin/autoAlias.sh
cowCommand

alias ?='. ~/bin/cowCommand.sh'
alias ccat='pygmentize -g -O style=colorful'
#alias ls='ls -FGh'
alias ls='ls --color=auto -Fh'

#. ~/bin/autoAlias.sh
shopt -s cdable_vars
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



export PYTHONPATH='$HOME/Library/Python/3.7/bin'
# added by Anaconda3 installer
export LS_OPTIONS=‘–color=auto’
d=~/.dir_colors
test -r $d && eval "$(dircolors $d)"

end=`date +%s.%N`
runtime=$( echo "$end - $start"|bc -l )
echo "$runtime seconds"
