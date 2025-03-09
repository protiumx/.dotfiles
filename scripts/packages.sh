taps=(
  homebrew/cask
  homebrew/cask-fonts
  homebrew/core
  wez/wezterm
)

packages=(
  bat    # https://github.com/sharkdp/bat
  bottom # https://github.com/ClementTsang/bottom
  cmake
  ctags
  curl
  dasel # https://github.com/TomWright/dasel
  dust  # https://github.com/bootandy/dust
  eza   # https://github.com/eza-community/eza
  fzf   # https://github.com/junegunn/fzf
  fd    # https://github.com/sharkdp/fd
  gettext
  git-delta # https://github.com/dandavison/delta
  gpg
  go
  graphviz # https://graphviz.org/
  grpcurl  # https://github.com/fullstorydev/grpcurl
  imagemagick
  jq
  k9s # https://github.com/derailed/k9s
  kubernetes-cli
  hyperfine  # https://github.com/sharkdp/hyperfine
  lazydocker # https://github.com/jesseduffield/lazydocker
  lf         # https://github.com/gokcehan/lf
  libpq
  lynx # https://lynx.invisible-island.net/
  mas  # https://github.com/mas-cli/mas
  minikube
  neovim
  node
  nmap
  openssl
  pinentry-mac
  postgresql
  python3
  protobuf
  ripgrep # https://github.com/BurntSushi/ripgre
  rustup
  # sd         # https://github.com/chmln/sd
  shellcheck
  stow
  stylua # https://github.com/JohnnyMorganz/StyLua
  telnet
  xo/xo/usql # https://github.com/xo/usql
  # websocat   # https://github.com/vi/websocat
  wget
  zsh
  zinit  # https://github.com/zdharma-continuum/zinit
  zoxide # https://github.com/ajeetdsouza/zoxide
)

install_packages() {
  info "Configuring taps"
  apply_brew_taps "${taps[@]}"

  info "Installing packages..."
  install_brew_formulas "${packages[@]}"

  info "Cleaning up brew packages..."
  brew cleanup
}
