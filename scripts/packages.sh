taps=(
  homebrew/cask
  homebrew/cask-fonts
  homebrew/core
  ox/ox
  vmware-tanzu/carvel
  wez/wezterm
)

packages=(
  bat                      #  https://github.com/sharkdp/bat
  bandwhich                #  https://github.com/imsnif/bandwhich
  bottom                   #  https://github.com/ClementTsang/bottom
  cmake
  ctags
  curl
  dasel                    #  https://github.com/TomWright/dasel
  dust                     #  https://github.com/bootandy/dust
  exa                      #  https://github.com/ogham/exa
  fzf                      #  https://github.com/junegunn/fzf
  fd                       #  https://github.com/sharkdp/fd
  gettext
  git-delta                #  https://github.com/dandavison/delta
  gpg
  go
  graphviz                 #  https://graphviz.org/
  grpcurl                  #  https://github.com/fullstorydev/grpcurl
  httpie                   #  https://github.com/httpie/httpie
  imagemagick
  jless                    #  https://github.com/PaulJuliusMartinez/jless
  jq
  k9s                      #  https://github.com/derailed/k9s
  kubernetes-cli
  hyperfine                #  https://github.com/sharkdp/hyperfine
  lazydocker               #  https://github.com/jesseduffield/lazydocker
  lf                       #  https://github.com/gokcehan/lf
  libpq
  mas                      #  https://github.com/mas-cli/mas
  minikube
  neovim
  node
  nmap
  openjdk
  openssl
  pinentry-mac
  postgresql
  procs                    #  https://github.com/dalance/procs/
  python3
  protobuf
  ripgrep                  #  https://github.com/BurntSushi/ripgre
  rustup
  sd                       #  https://github.com/chmln/sd
  shellcheck
  stow
  telnet
  usql                     #  https://github.com/xo/usql
  websocat                 #  https://github.com/vi/websocat
  wget
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
  zoxide                   #  https://github.com/ajeetdsouza/zoxide
)

install_packages() {
  info "Configuring taps"
  apply_brew_taps "${taps[@]}"

  info "Installing packages..."
  install_brew_formulas "${packages[@]}"

  info "Cleaning up brew packages..."
  brew cleanup
}

post_install_packages() {
  info "Installing fzf bindings"
  # shellcheck disable=SC2046
  $(brew --prefix)/opt/fzf/install
}
