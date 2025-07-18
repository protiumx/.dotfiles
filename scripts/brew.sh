install_brew_formulas() {
  local formulas=$*
  for formula in $formulas; do
    if brew list --formula | grep $(basename $formula) >/dev/null; then
      warn "Formula $formula is already installed"
    else
      info "Installing package < $formula >"
      brew install "$formula"
    fi
  done
}

install_brew_casks() {
  local casks=$*
  for cask in $casks; do
    if brew list --casks | grep "$cask" >/dev/null; then
      warn "Cask $cask is already installed"
    else
      info "Installing cask < $cask >"
      brew install --cask "$cask"
    fi
  done
}
