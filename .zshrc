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

# history file
HISTFILE=~/.zsh_history

# history size
export HISTSIZE=10000

# history file size
export SAVEHIST=10000

# history ignore dumps
setopt hist_ignore_dups

# history ignore all dups
setopt hist_ignore_all_dups

# history ignore space
setopt hist_ignore_space

# history verify
setopt hist_verify

# history share
setopt share_history

# history start timestamp
setopt extended_history

# history timestamp format
HIST_STAMPS="yyyy-mm-dd"

# history ignore same
setopt hist_reduce_blanks

# history isno store
setopt hist_no_store

# history expand
setopt hist_expand

# history append incrimental
setopt inc_append_history




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



############
# function
############ 

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# Shell Integration済みであること
iterm2_print_user_vars() {
  iterm2_set_user_var test $(badge)
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

# peco
function peco-history-selection() {
  BUFFER=`history -n 1 | tac -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

# peco-cdr
function peco-cdr () {
  local selected_dir="$(cdr -l | awk '{$1=""; sub(" ", ""); print $0}' | peco --prompt="cdr >" --query "$LBUFFER")"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N peco-cdr
bindkey '^E' peco-cdr

## ghq
function peco-src () {
  local selected_dir=$(ghq list -p | peco --prompt="repositories >" --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^X' peco-src
