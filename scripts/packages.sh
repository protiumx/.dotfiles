taps=(
  hashicorp/tap
  helm/tap
  homebrew/cask
  homebrew/cask-fonts
  homebrew/core
  vmware-tanzu/carvel
)

packages=(
  # styled cat
  bat
  # tree listing for files
  broot
  cmake
  ctags
  curl
  # to set default handlers for file types in MacOS
  duti
  gettext
  go
  http-server  
  httpie
  jq
  kubernetes-cli
  node
  nmap
  openjdk
  openssl
  python3
  protobuf
  # fuzzy grep
  ripgrep
  rlwrap
  rustup
  sqlite
  stow
  telnet
  # telnet-like for websockets
  websocat
  yarn
  ytt
  wget
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
)

function install_packages() {
  print_blue "Configuring taps"
  apply_brew_taps "${taps[@]}"
  print_blue "Installing macOS and Linux packages..."
  install_brew_formulas "${packages[@]}"
  print_blue "Cleaning up brew packages..."
  brew cleanup
}
