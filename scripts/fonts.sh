fonts=(
  font-caskaydia-cove-nerd-font
  font-consolas-for-powerline
  font-fira-code-nerd-font
  font-fira-code
  font-menlo-for-powerline
  font-meslo-lg-dz
  font-meslo-lg-nerd-font
  font-meslo-lg
)

install_fonts() {
  info "Installing fonts..."
  brew tap homebrew/cask-fonts
  install_brew_casks "${fonts[@]}"
}
