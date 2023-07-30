apps=(
  arduino
  clipy               # Clipboard manager https://github.com/Clipy/Clipy
  deepl
  discord
  docker
  firefox
  google-chrome
  rectangle           # Window util
  slack
  spotify
  visual-studio-code
  vlc
  wez/wezterm/wezterm # Terminal https://wezfurlong.org/wezterm
)

mas_apps=(
  "937984704"   # Amphetamine
  "1444383602"  # Good Notes 5
  "768053424"   # Gappling (svg viewer)
)

install_macos_apps() {
  info "Installing macOS apps..."
  install_brew_casks "${apps[@]}"
}

install_masApps() {
  info "Installing App Store apps..."
  for app in "${mas_apps[@]}"; do
    mas install "$app"
  done
}
