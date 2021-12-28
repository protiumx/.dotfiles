apps=(
  arduino
  caffeine
  clipy
  discord
  docker
  firefox
  google-chrome
  kitty
  rectangle
  slack
  spotify
  typora
  visual-studio-code
  vlc
)

install_macos_apps() {
  info "Installing macOS apps..."
  brew tap homebrew/cask
  install_brew_casks "${apps[@]}"
}
