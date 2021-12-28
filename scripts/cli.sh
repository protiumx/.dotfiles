function install_xcode_clt() {
  if xcode-select -p > /dev/null; then
    print_yellow "XCode Command Line Tools already installed"
  else
    print_blue "Installing XCode Command Line Tools..."
    xcode-select --install
    sudo xcodebuild -license accept
  fi
}

function install_python_packages() {
  print_blue "Installing pip"
  curl https://bootstrap.pypa.io/get-pip.py | python

  pip install xkcdpass
}

function install_neovim {
  print_blue "Installing NeoVim"
  install_brew_formulas neovim
  print_blue "Installing Vim Plugged"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}
