install_macos_apps() {
  local apps=(
    arduino
    clipy # https://github.com/Clipy/Clipy
    firefox
    google-chrome
    spotify
    vlc
    wez/wezterm/wezterm # https://wezfurlong.org/wezterm
  )

  info "Installing macOS apps..."
  install_brew_casks "${apps[@]}"
}

install_masApps() {
  local apps=(
    "1444383602" # Good Notes 5
    "768053424"  # Gappling: svg viewer https://apps.apple.com/us/app/gapplin/id768053424
  )

  info "Installing App Store apps..."
  for app in "${apps[@]}"; do
    mas install "$app"
  done
}
