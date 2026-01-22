# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Change go PATH
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"



alias ls="ls --color=auto"
alias grep="grep --color=auto --exclude-dir=.git --exclude-dir=node_modules"

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgreprc"

export EDITOR=nvim

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --style=default \
  --margin=0% \
  --color=base16 \
  --preview-window 'right,border-rounded,hidden'
  --multi \
  --bind ctrl-q:toggle-all,alt-q:toggle-all,ctrl-o:toggle-preview \
  --bind ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up "

export ZOXIDE_EXCLUDE='/tmp/*'
eval "$(zoxide init bash)"

# Dotfiles
alias dot='/usr/bin/git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME"'
