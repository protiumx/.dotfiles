CLI="$HOME/.cli"
VSCODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"
export PATH="$VSCODE:/opt/local/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export GOPATH="$(go env GOPATH)"
export PATH="$GOPATH/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export EDITOR=vim

eval "$(zoxide init zsh)"

# ITERM bindings
# changes hex 0x15 to delete everything to the left of the cursor, rather than the whole line
bindkey "^U" backward-kill-line
# binds hex 0x18 0x7f with deleting everything to the left of the cursor
bindkey "^X\\x7f" backward-kill-line
# adds redo
bindkey "^X^_" redo

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR="nvim"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt appendhistory           # Immediately append history instead of overwriting
setopt nobeep                  # No beep

#Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
#Initialization code that may require console input (password prompts, [y/n]
#confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

brew_prefix="$(brew --prefix)"

source $brew_prefix/opt/powerlevel10k/powerlevel10k.zsh-theme
source $brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export ZSH="$HOME/.oh-my-zsh"

# Fix preview-tui
export PAGER='less -R'

source $ZSH/oh-my-zsh.sh
source $HOME/.p10k.zsh
source $HOME/.config/broot/launcher/bash/br
source $HOME/.cargo/env

export NVM_DIR="$HOME/.nvm"

[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source all profile files
for file in $HOME/.profile*; do
  source "$file"
done
