taps=(
  homebrew/cask
  homebrew/cask-fonts
  homebrew/core
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
  dust                     #  https://github.com/bootandy/dust
  exa                      #  https://github.com/ogham/exa
  fzf                      #  https://github.com/junegunn/fzf
  fd                       #  https://github.com/sharkdp/fd
  gettext
  gh
  git-delta                #  https://github.com/dandavison/delta
  go
  grpcurl                  #  https://github.com/fullstorydev/grpcurl
  httpie                   #  https://github.com/httpie/httpie
  imagemagick
  jq
  k9s                      #  https://github.com/derailed/k9s
  kubernetes-cli
  hyperfine                #  https://github.com/sharkdp/hyperfine
  lazydocker               #  https://github.com/jesseduffield/lazydocker
  lf                       #  https://github.com/gokcehan/lf
  libpq
  minikube
  node
  nmap
  openjdk
  openssl
  postgresql
  procs                    #  https://github.com/dalance/procs/
  python3
  protobuf
  ripgrep                  #  https://github.com/BurntSushi/ripgrep
  rustup
  shellcheck
  stow
  telnet
  websocat                 #  https://github.com/vi/websocat
  yarn
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
  $(brew --prefix)/opt/fzf/install

  info "Cloning Packer"
  git clone --depth 1 https://github.com/wbthomason/packer.nvim /.local/share/nvim/site/pack/packer/start/packer.nvim
}
