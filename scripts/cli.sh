install_python_packages() {
  info "Installing pip"
  curl https://bootstrap.pypa.io/get-pip.py | python

  info "Installing pip xkcdpass"
  pip install xkcdpass
}

install_neovim() {
  info "Installing NeoVim"
  install_brew_formulas neovim

  info "Installing Vim Plugged"
  sh -c 'curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}
