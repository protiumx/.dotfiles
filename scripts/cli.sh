pip_packages=(
  black
  xkcdpass
)

install_python_packages() {
  for p in "${pip_packages[@]}"; do
    if pip3 show "$p" > /dev/null; then
      warn "Package $p is already installed"
    else
      info "Installing package < $p >"
      pip3 install "$p"
    fi
  done
}
