taps=(
  hashicorp/tap
  helm/tap
  helix-editor/helix
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
  duti            # to set default handlers for file types in MacOS
  fzf
  gettext
  gh
  go
  hashicorp/tap/terraform
  helm
  helix
  http-server
  httpie
  htop
  imagemagick
  jq
  k9s
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
  shellcheck
  sqlite
  stern
  stow
  telnet
  tree
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
