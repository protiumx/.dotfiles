function install_xcode_clt() {
  if xcode-select -p > /dev/null; then
    print_yellow "XCode Command Line Tools already installed"
  else
    print_blue "Installing XCode Command Line Tools..."
    xcode-select --install
  fi
}

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

function install_neovim {
  print_blue "Installing NeoVim"
  install_brew_formulas neovim
  print_blue "Installing Vim Plugged"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'  
}
