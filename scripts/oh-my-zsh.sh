install_oh_my_zsh() {
  if [[ ! -f ~/.zshrc ]]; then
    info "Installing oh my zsh..."
    ZSH=~/.oh-my-zsh ZSH_DISABLE_COMPFIX=true sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    chmod 744 ~/.oh-my-zsh/oh-my-zsh.sh
  else
    warn "oh-my-zsh already installed"
  fi
}
