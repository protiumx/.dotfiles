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

function install_fonts() {
  print_blue "Installing fonts..."
  brew tap homebrew/cask-fonts
  install_brew_casks "${fonts[@]}"
}
