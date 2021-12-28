install_oh_my_zsh() {
  if [[ ! -f ~/.zshrc ]]; then
    info "Installing oh my zsh..."
    ZSH=~/.oh-my-zsh ZSH_DISABLE_COMPFIX=true sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    chmod 744 ~/.oh-my-zsh/oh-my-zsh.sh
    
    info "Installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
  else
    warn "oh-my-zsh already installed"
  fi
}

install_zsh_plugins() {
  info "Installing zsh-z"
  git clone https://github.com/agkozak/zsh-z $ZSH/plugins/zsh-z
  
  success "Installed zsh-z"
}
