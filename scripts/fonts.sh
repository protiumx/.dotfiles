fonts=(
  font-caskaydia-cove-nerd-font
  font-consolas-for-powerline
  font-fira-code-nerd-font
  font-fira-code
)

install_fonts() {
  info "Installing fonts..."
  brew tap homebrew/cask-fonts
  install_brew_casks "${fonts[@]}"
}
