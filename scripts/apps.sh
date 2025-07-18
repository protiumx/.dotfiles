install_macos_apps() {
  local apps=(
    arduino
    clipy # https://github.com/Clipy/Clipy
    firefox
    google-chrome
    spotify
    vlc
  )

  info "Installing macOS apps..."
  install_brew_casks "${apps[@]}"
}
