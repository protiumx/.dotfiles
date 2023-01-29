# Disable error when using glob patterns that don't have matches
setopt +o nomatch
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

CLI="$HOME/.cli"

# Pasting big chunks of text takes ages
unset zle_bracketed_paste

export PATH="$GOPATH/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(fzf-tab)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# ITERM bindings
# changes hex 0x15 to delete everything to the left of the cursor, rather than the whole line
bindkey "^U" backward-kill-line
# binds hex 0x18 0x7f with deleting everything to the left of the cursor
bindkey "^X\\x7f" backward-kill-line
# adds redo
bindkey "^X^_" redo

export GPG_TTY=$(tty)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR="nvim"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt appendhistory           # Immediately append history instead of overwriting
setopt nobeep                  # No beep

brew_prefix="$(brew --prefix)"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
source $brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Fix issue autocomplete after paste
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
source $brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source all profile files
for file in $HOME/.profile*; do
  source "$file"
done

export GOPATH="$(go env GOPATH)"

gpgconf --launch gpg-agent
