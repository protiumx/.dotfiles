#!/usr/bin/env zsh

# Disable error when using glob patterns that don't have matches
setopt +o nomatch

: "$LANG:=\"en_US.UTF-8\""
: "$LANGUAGE:=\"en\""
: "$LC_CTYPE:=\"en_US.UTF-8\""
: "$LC_ALL:=\"en_US.UTF-8\""
export LANG LANGUAGE LC_CTYPE LC_ALL

export TERM="screen-256color"
export GPG_TTY=$(tty)
export EDITOR="nvim"
export HISTSIZE=10000
export SAVEHIST=10000

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rg"

export MANPAGER='less -s'
# Enable highlighting in Less, useful for manpages
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

BREW_PREFIX="$(brew --prefix)"

################# Oh MyZsh ####################

export ZSH="$HOME/.oh-my-zsh"

# Use hyphen-insensitive completion: _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Disable command auto-correction.
ENABLE_CORRECTION="false"

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Change the command execution time stamp shown in the history command output
HIST_STAMPS="dd.mm.yyyy"

ZSH_THEME=""

# Fix slow bracketed-paste
DISABLE_MAGIC_FUNCTIONS="true"

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt appendhistory           # Immediately append history instead of overwriting
setopt nobeep

plugins=(
  docker                  # auto-completion for docker
  fzf-tab
)

# Enable option-stacking for docker (i.e docker run -it <TAB>)
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE='100' # limit suggestion to 100 chars

source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Fix issue autocomplete after paste
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

################# Config ####################

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# changes ctrl-u to delete everything to the left of the cursor, rather than the whole line
bindkey "^U" backward-kill-line
# alt-del delete word forwards
bindkey '^[[3;3~' kill-word

# zsh syntax highlighting clears and restores aliases after .zshenv is loaded
# this keeps ls and ll aliased correctly
alias ls="exa --group-directories-first -G  --color auto --icons -a -s type"
alias ll="exa --group-directories-first -l --color always --icons -a -s type"

# Golang
export GOPATH="$HOME/go"
# export GOROOT="$HOME/go/current"

[ -d "$GOPATH/bin" ] && PATH="$GOPATH/bin:$PATH"
[ -d "/usr/local/go/bin" ] && PATH="/usr/local/go/bin:$PATH"

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

[ -f ~/.fzf.zsh ] && source $HOME/.fzf.zsh

# K8s completions
[[ -x "$(command -v kubectl)" ]] && source <(kubectl completion zsh)

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
if [[ "$OSTYPE" =~ ^darwin ]]; then
  ssh-add --apple-load-keychain &>/dev/null
fi
