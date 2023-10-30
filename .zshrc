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


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# Shell Integration済みであること
iterm2_print_user_vars() {
  iterm2_set_user_var test $(my_badge)
}

# badge
function badge() {
  printf "\e]1337;SetBadgeFormat=%s\a"\
  $(echo -n "$1" | base64)
}

function ssh_local() {
  local ssh_config=~/.ssh/config
  local server=$(cat $ssh_config | grep "Host " | sed "s/Host //g" | fzf)
  if [ -z "$server" ]; then
    return
  fi
  badge $server
  ssh $server
}
