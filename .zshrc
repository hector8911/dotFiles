autoload -U colors && colors
alias ls='ls --color=auto'
LS_COLORS='di=01;34:fi=33:ln=01;36:pi=40;33:so=01;35:bd=5:cd=5:or=31:mi=0:ex=1;32:*.png=95:*.jpg=95'
export LS_COLORS

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
HISTORY_IGNORE="(ls *|cd *|pwd|neofetch|lf|which *|echo *)"

# Auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Vi mode
bindkey -v
export KEYTIMEOUT=1

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "\e[A" up-line-or-beginning-search
bindkey "\e[B" down-line-or-beginning-search

# Update cursor
function zle-keymap-select() {
		if [[ ${KEYMAP} == vicmd ]]; then
				echo -ne "\e[2 q"
		else
				echo -ne "\e[6 q"
		fi
}

zle -N zle-keymap-select
precmd(){ echo -ne '\e[6 q' ;}

# Switch directory  ctrl-space
bindkey -s '^ ' 'lf\n'
alias lf='lf --last-dir-path=$HOME/.lastDir; LASTDIR=`cat $HOME/.lastDir`; cd "$LASTDIR"'
alias nv='nvim'
setopt HIST_IGNORE_ALL_DUPS

SPACESHIP_PROMPT_ORDER=( dir git char )
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL=❯
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_DIR_TRUNC=1
autoload -U promptinit;

promptinit
prompt spaceship

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
