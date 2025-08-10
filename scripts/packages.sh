packages=(
  bat                  # https://github.com/sharkdp/bat
  bash-language-server # https://github.com/bash-lsp/bash-language-server
  bottom               # https://github.com/ClementTsang/bottom
  buf                  # https://buf.build/
  cmake
  curl
  dust      # https://github.com/bootandy/dust
  eza       # https://github.com/eza-community/eza
  fzf       # https://github.com/junegunn/fzf
  fd        # https://github.com/sharkdp/fd
  git-delta # https://github.com/dandavison/delta
  gpg
  go       # golang
  graphviz # https://graphviz.org/
  hexyl    # https://github.com/sharkdp/hexyl
  imagemagick
  jq
  kubernetes-cli
  hyperfine # https://github.com/sharkdp/hyperfine
  libpq     # psql
  lua-language-server
  neovim
  node
  nmap
  pinentry-mac
  python
  protobuf
  ripgrep # https://github.com/BurntSushi/ripgre
  rustup
  ruff # https://github.com/astral-sh/ruff
  sd   # https://github.com/chmln/sd
  shellcheck
  shfmt # https://github.com/mvdan/sh
  starship
  stow
  telnet
  xo/xo/usql # https://github.com/xo/usql
  yazi       # https://github.com/sxyazi/yazi
  wget
  zsh
  zinit  # https://github.com/zdharma-continuum/zinit
  zoxide # https://github.com/ajeetdsouza/zoxide
)

install_packages() {
  info "Installing packages..."
  install_brew_formulas "${packages[@]}"

  info "Cleaning up brew packages..."
  brew cleanup
}
