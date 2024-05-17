#!/usr/bin/env zsh

: "$LANG:=\"en_US.UTF-8\""
: "$LANGUAGE:=\"en\""
: "$LC_CTYPE:=\"en_US.UTF-8\""
: "$LC_ALL:=\"en_US.UTF-8\""

# export GPG_TTY=$(tty)
export DOCKER_SCAN_SUGGEST=false
export EDITOR="nvim"
export GPG_TTY=$(tty)
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export LANG LANGUAGE LC_CTYPE LC_ALL
export MANPAGER='nvim +Man!'
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rg"
export TERM="screen-256color"

export DYLD_LIBRARY_PATH="$HOME/.config/nvim/lua/config/nvim"
export LD_LIBRARY_PATH="$HOME/.config/nvim/lua/config/nvim"

# Less highlighting
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;94m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

export PICO_SDK_PATH="$HOME/dev/pico-sdk"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ZSH Config
# Plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light Aloxaf/fzf-tab

# K8s completions
[[ -x "$(command -v kubectl)" ]] && source <(kubectl completion zsh)

autoload -Uz compinit && compinit

zinit cdreplay -q

bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

# Use hyphen-insensitive completion: _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="false"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="dd.mm.yy"
# Fix slow bracketed-paste
DISABLE_MAGIC_FUNCTIONS="true"

set completion-ignore-case on
# Do not autocomplete hidden files unless the pattern explicitly begins with a dot
set match-hidden-files off

HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help"
HISTDUP=erase

setopt appendhistory # Immediately append history instead of overwriting
setopt sharehistory # Share hist with all sessions
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt nobeep
# Disable error when using glob patterns that don't have matches
setopt +o nomatch

# Enable option-stacking for docker (i.e docker run -it <TAB>)
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE='100' # limit suggestion to 100 chars
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

################# Config ####################

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# changes ctrl-u to delete everything to the left of the cursor, rather than the whole line
bindkey "^U" backward-kill-line
# alt-del delete word forwards
bindkey '^[[3;3~' kill-word

# zsh syntax highlighting clears and restores aliases after .zshenv is loaded
# this keeps ls and ll aliased correctly
alias ls="eza --group-directories-first -G  --color auto --icons -a -s type"
alias ll="eza --group-directories-first -l --color always --icons -a -s type"

# Add aliases to completion
compdef g='git'
compdef k='kubectl'

# Golang
export GOPATH="$HOME/go"
[ -d "$GOPATH/bin" ] && PATH="$GOPATH/bin:$PATH"

# Rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

# FZF

# Excluded dirs are set in ../fd/ignore
export FZF_DEFAULT_COMMAND="fd -d 1 --hidden --no-ignore-vcs --follow --color=never --strip-cwd-prefix"
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --prompt '  '
  --pointer ' '
  --marker '~ '
  --multi
  --bind 'ctrl-p:toggle-preview'
  --bind 'ctrl-e:become(nvim {})'
  --preview='bat {}'
  --preview-window 'hidden,border-left'
  --no-info
  --scrollbar=▏▕
  --color 'gutter:-1,hl+:#82aaff,hl:#82aaff,bg+:-1,pointer:#82aaff'"
export FZF_COMPLETION_OPTS=$FZF_DEFAULT_OPTS

# zoxide fzf opts
export _ZO_FZF_OPTS=$FZF_DEFAULT_OPTS

_fzf_compgen_path() {
	fd --hidden --follow --exclude ".git/" . "$1"
}

# Use fd to generate the list for directory completion
# Needs trigger **
_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git/" . "$1"
}


[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"
export PATH

# Source all profile files
for file in $HOME/.profile*; do
	source "$file"
done

# Start ssh agent
if [[ "$OSTYPE" =~ ^linux ]]; then
	eval $(ssh-agent) >/dev/null
fi

# Add ssh keys to apple keychain
# Commented out in favor of macos/com.openssh.ssh-agent.plist
# if [[ "$OSTYPE" =~ ^darwin ]]; then
# 	ssh-add --apple-load-keychain &>/dev/null
# fi

################# ZSH widgets ####################

# search changed files in git repo
fzf-git-files-widget() {
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    return 1
  fi

  local files=$(git diff --name-only)
  local lines=$(echo $files | wc -l)
  if [ $lines -eq 0 ]; then
    return 0
  fi

  if [ $lines -eq 1 ]; then
    RBUFFER=$files
  else
    local selected
    if selected=$(echo $files | fzf); then
      RBUFFER=$selected
    fi
  fi

  zle redisplay
  zle end-of-line
}

zle -N fzf-git-files-widget
bindkey -r '\eg'
bindkey '\eg' fzf-git-files-widget

# go back to fg
zsh-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N zsh-ctrl-z
bindkey '^z' zsh-ctrl-z

# edit current folder
zsh-ctrl-o () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="nvim ."
    zle accept-line
  fi
}
zle -N zsh-ctrl-o
bindkey -r '^o'
bindkey '^o' zsh-ctrl-o

echo "( .-.)"
