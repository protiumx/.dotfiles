#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

. scripts/utils.sh
. scripts/brew.sh
. scripts/apps.sh
. scripts/cli.sh
. scripts/config.sh
. scripts/osx.sh
. scripts/fonts.sh
. scripts/packages.sh
. scripts/oh-my-zsh.sh

cleanup() {
  info "Finishing..."
}

wait_input() {
  read -p "Press enter to continue: "
}

trap cleanup SIGINT SIGTERM ERR EXIT

main() {
  info "Installing ..."

  if [ -z "${SSH_PASSPHRASE}" ]; then
    echo "SSH_PASSPHRASE not set"
    exit 1
  fi

  info "Homebrew Packages"
  info "################################################"
  wait_input
  install_packages
  success "Finished installing Homebrew packages"

  info "Homebrew Fonts"
  info "################################################"
  wait_input
  install_fonts
  success "Finished installing fonts"

  # info "Oh-my-zsh"
  # wait_input
  # install_oh_my_zsh
  # success "Finished installing Oh-my-zsh"

  info "MacOS Apps"
  info "################################################"
  wait_input
  install_macos_apps

  install_masApps
  success "Finished installing macOS apps"

  info "NeoVim"
  info "################################################################################"
  wait_input
  install_neovim
  success "Finished installing neovim"

  info "PiP modules"
  info "################################################################################"
  wait_input
  install_python_packages
  success "Finished installing python packages"

  info "Configuration"
  info "################################################################################"
  wait_input
  setup_osx
  success "Finished configuring MacOS defaults. NOTE: A restart is needed"
  code_as_default_text_editor
  success "Finished setting up VSCode as default text editor"
  stow_dotfiles

  info "Crating development folders"
  info "################################################################################"
  mkdir -p ~/Development/protiumx

  success "Finished stowing dotfiles"

  info "SSH Key"
  info "################################################################################"
  setup_github_ssh
  success "Finished setting up SSH Key"

  info "NeoVim Plugins"
  info "################################################################################"
  wait_input
  nvim +PlugInstall +qall
  success "Finished installing nvim plugins"

  if ! hash rustc &>/dev/null; then
    info "Rust Setup"
    info "################################################################################"
    wait_input
    rustup-init
  fi

  success "Done"

  info "System needs to restart. Restart?"

  select yn in "y" "n"; do
    case $yn in
        y ) sudo shutdown -r now; break;;
        n ) exit;;
    esac
  done
}

main
