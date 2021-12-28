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

function install_macos_apps() {
  print_blue "Installing macOS apps..."
  brew tap homebrew/cask
  install_brew_casks "${apps[@]}"
}
