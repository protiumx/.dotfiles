function install_oh_my_zsh() {
  if [[ ! -f ~/.zshrc ]]; then
    print_blue "Installing oh my zsh..."
    ZSH=~/.oh-my-zsh ZSH_DISABLE_COMPFIX=true sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chmod 744 ~/.oh-my-zsh/oh-my-zsh.sh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
  else
    print_green "oh my zsh already installed"
  fi
}

function install_zsh_plugins() {
  print_blue "Installing zsh-z"
  git clone https://github.com/agkozak/zsh-z $ZSH/plugins/zsh-z
  print_green "Installed zsh-z"
}
