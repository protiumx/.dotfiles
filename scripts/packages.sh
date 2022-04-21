taps=(
  hashicorp/tap
  helm/tap
  homebrew/cask
  homebrew/cask-fonts
  homebrew/core
  vmware-tanzu/carvel
)

packages=(
  bat             # styled cat
  bottom          # tree listing for files
  broot
  cmake
  ctags
  curl
  duti # to set default handlers for file types in MacOS
  fzf
  gettext
  go
  hashicorp/tap/terraform
  http-server
  httpie
  imagemagick
  jq
  kubernetes-cli
  lazydocker
  libpq
  macpass
  minikube
  node
  nvm
  nmap
  openjdk
  openssl
  postgresql
  python3
  protobuf
  ripgrep          # fuzzy grep
  rlwrap
  rustup
  sqlite
  stern
  stow
  telnet
  websocat         # telnet-like for websockets
  yarn
  ytt
  wget
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
)

install_packages() {
  info "Configuring taps"
  apply_brew_taps "${taps[@]}"

  info "Installing packages..."
  install_brew_formulas "${packages[@]}"

  info "Cleaning up brew packages..."
  brew cleanup
}
