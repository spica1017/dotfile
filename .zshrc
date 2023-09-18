##############
#    main    
##############

# Don't Ctrl+D
setopt IGNOREEOF

# Use Japanese
export LANG=ja_JP.UTF-8

# User colors
autoload -Uz colors
colors

# Use compinit
autoload -Uz compinit
compinit

# No cd move
setopt auto_cd

# Keybind
bindkey -v

# push
setopt auto_pushd
setopt pushd_ignore_dups

# spel check
setopt correct

# clobber
setopt no_clobber





##############
# alias
##############

# ls
alias ls='ls -l --color=auto'
alias ll='ls -alF --color=auto'

# cd
alias d='cd ~/dotfile'

# neovim
alias vi='nvim'
alias vim='nvim'


#############
# Export
#############

# Editor
export EDITOR=nvim

# nvim config file
export XDG_CONFIG_HOME=~/dotfile


############
# evaluate
############

# Load Sheldon
eval "$(sheldon source)"

