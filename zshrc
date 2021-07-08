start=`gdate +%s.%N`

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source ~/.paths.sh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="MaxCoplanTheme"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
#Open Tmux
source ~/.profile

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH_CUSTOM=/path/to/new-custom-folder
fpath=(/usr/local/share/zsh-completions /usr/local/share/zsh-completions/conda-zsh-completion $fpath)
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -U promptinit && promptinit
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svn
autoload -Uz run-help-svk
unalias run-help
alias help=run-help

#source /usr/local/share/zsh-completions/helpers
. "/usr/local/etc/profile.d/bash_completion.sh"

#if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi
eval "$(brew command-not-found-init)"
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  osx
  colored-man-pages
  colorize
  pip
  python
  brew
  vi-mode  
  zsh-syntax-highlighting
  history-substring-search
  #zsh-autosuggestions
  #zsh-apple-touchbar
) 
source $ZSH/oh-my-zsh.sh
setopt vi
autoload -U edit-command-line
zle -N edit-command-line
# 10ms for key sequences
KEYTIMEOUT=1
bindkey -M vicmd "" edit-command-line

precmd_functions+=(zle-keymap-select)
#echo -ne "\e[5 q"
zle-keymap-select () {
    if [[ $KEYMAP == vicmd ]]; then
        # the command mode for vi
        echo -ne "\e[2 q"
    else
        # the insert mode for vi
        echo -ne "\e[5 q"
    fi
}

if [[ $'\e\x5b3D' == "$(echoti cub 3)" ]] &&
   [[ $'\e\x5b33m' == "$(echoti setaf 3)" ]]; then
  zstyle -e ':completion:*' list-colors $'reply=( "=(#b)(${(b)PREFIX})(?)([^ ]#)*=0=0=${PREFIX:+${#PREFIX}D${(l:$#PREFIX:: :):-…}\e\x5b}35=33" )'
fi
zstyle ':completion:*:*(directories|files)*' list-colors ''

export FZF_DEFAULT_OPTS='--height=70% --preview "bat --color always {} || cat {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_COMMAND='git ls-tree -r --name-only HEAD || rg --files 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source "$HOME/.fzf-extras/fzf-extras.zsh"
source "$HOME/.fzf-extras/fzf-extras.sh"


mkcdir ()
{
	mkdir -p -- "$1" &&
		cd -P -- "$1"
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/.aliases
source ~/.functions
alias pman='man-preview'
alias ls="gls --group-directories-first --color=tty -XhF"

#ZSH-SYTAX-HIGHLIGHTING
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=white

zstyle ':completion:*:*:vim:*' file-patterns '^*.class:source-files' '*:all-files'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"
RPS1="${return_code}"

source ~/.iterm2_shell_integration.zsh
cowCommand

eval "$(jenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/Users/maxcoplan/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

end=`gdate +%s.%N`
runtime=$( echo "$end - $start"|bc -l )
#runtime=$(echo "$end - $start"|bc -l)
echo "$runtime seconds"
