# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User variables
export HISTSIZE=500000
export SAVEHIST=500000

# Cursor
#echo -e -n "\x1b[\x30 q" # changes to blinking block
#echo -e -n "\x1b[\x31 q" # changes to blinking block also
#echo -e -n "\x1b[\x32 q" # changes to steady block
#echo -e -n "\x1b[\x33 q" # changes to blinking underline
echo -e -n "\x1b[\x34 q" # changes to steady underline
#echo -e -n "\x1b[\x35 q" # changes to blinking bar
#echo -e -n "\x1b[\x36 q" # changes to steady bar

# Find new executables in path
zstyle ':completion:*' rehash true

#This causes pasted URLs to be automatically escaped, without needing to disable globbing.
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Load 'Pure' zsh theme
autoload -U promptinit; promptinit
prompt pure

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias h="history"
alias p="pwd -P"
alias s="sudo -s"
alias cd="z"
alias CD="z"

# pacman aliases
alias pacsearch="pacman -Ss"
alias pacins="sudo pacman -S"
alias pacup="sudo pacman -Sy archlinux-keyring --needed && sudo pacman -Syu"
alias pacrm="sudo pacman -Rns"
alias pacorphans="pacman -Qdtq"

# Quick edit
alias xr="vim ~/.Xresources"
alias zshrc="vim ~/.zshrc"
alias rc.lua="vim ~/.config/awesome/rc.lua"
alias awesomeconf="ranger ~/.config/awesome"
alias kittyconf="vim ~/.config/kitty/kitty.conf"
alias fontconf="vim ~/.config/fontconfig/fonts.conf"

# Other aliases
alias ll="ls -A -h -l --group-directories-first --color=auto"
alias vol="pamixer --set-volume"
alias localip="ip -4 -br a"
alias portgrep="ss -tanp | grep "

# University-related aliases
source ~/.university_aliases

# Zoxide
eval "$(zoxide init zsh)"
