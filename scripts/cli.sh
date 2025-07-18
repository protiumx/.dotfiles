install_python_tools() {
  local packages=(
    black # https://github.com/psf/black
  )

  for p in "${packages[@]}"; do
    if pip3 show "$p" >/dev/null; then
      warn "Package $p is already installed"
    else
      info "Installing package < $p >"
      pip3 install "$p"
    fi
  done
}

install_go_tools() {
  local packages=(
    "github.com/go-delve/delve/cmd/dlv@latest"
    "mvdan.cc/sh/v3/cmd/shfmt@latest"
    "mvdan.cc/gofumpt@latest"
    "golang.org/x/tools/gopls@latest"
    "golang.org/x/tools/cmd/goimports@latest"
  )

  for p in "${packages[@]}"; do
    if ! command -v "$p" &>/dev/null; then
      info "Installing go tool < $p >"
      go install "$p"
    else
      info "$p is already installed"
    fi
  done
}

install_rust_tools() {
  source "$HOME/.cargo/env"

  if ! command -v rust-analyzer &>/dev/null; then
    info "Installing rust-analyzer"
    brew install rust-analyzer
  fi

  local cargo_packages=(
    "cargo-audit --features=fix"
    cargo-edit
    cargo-update
  )

  for p in "${cargo_packages[@]}"; do
    info "Installing <cargo $p>"
    expand=($p)
    cargo install "${expand[@]}"
  done

  local rustup_components=(
    rustfmt
    clippy
  )

  for p in "${rustup_components[@]}"; do
    info "Installing <rustup $p>"
    rustup component add "$p"
  done
}
