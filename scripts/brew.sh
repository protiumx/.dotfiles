function install_homebrew() {
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
  if hash brew &>/dev/null; then
    print_yellow "Homebrew already installed"
    print_blue "Updating brew"
    brew update
  else
    print_blue "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

function apply_brew_taps() {
  local tap_packages=$*
  for tap in $tap_packages; do
    if brew tap | grep "$tap" > /dev/null; then
      print_yellow "Tap $tap is already applied"
    else
      brew tap "$tap"
    fi
  done
}

function install_brew_formulas() {
  local formulas=$*
  for formula in $formulas; do
    if brew list --formula | grep "$formula" > /dev/null; then
      print_yellow "Formula $formula is already installed"
    else
      print_blue "Installing package < $formula >"
      brew install "$formula"
    fi
  done
}

function install_brew_casks() {
  local casks=$*
  for cask in $casks; do
    if brew list --casks | grep "$cask" > /dev/null; then
      print_yellow "Cask $cask is already installed"
    else
      print_blue "Installing cask < $cask >"
      brew install --cask "$cask"
    fi
  done
}
