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
. scripts/packages.sh

cleanup() {
  info "Finishing..."
}

wait_input() {
  read -p -r "Press enter to continue: "
}

main() {
  info "Dotfiles setup"

  info "################################################################################"
  info "Homebrew Packages"
  info "################################################################################"
  wait_input
  install_packages

  success "Finished installing Homebrew packages"

  info "################################################################################"
  info "Oh-my-zsh"
  info "################################################################################"
  wait_input
  install_oh_my_zsh
  success "Finished installing Oh-my-zsh"

  info "################################################################################"
  info "MacOS Apps"
  info "################################################################################"
  wait_input
  install_macos_apps

  install_masApps
  success "Finished installing macOS apps"

  info "################################################################################"
  info "PiP tools"
  info "################################################################################"
  wait_input
  install_python_tools
  success "Finished installing python packages"

  info "################################################################################"
  info "Rust tools"
  info "################################################################################"
  wait_input
  install_rust_tools
  success "Finished installing Rust tools"

  info "################################################################################"
  info "Golang tools"
  info "################################################################################"
  wait_input
  install_go_tools
  success "Finished installing Golang tools"

  info "################################################################################"
  info "Configuration"
  info "################################################################################"
  wait_input

  setup_osx
  success "Finished configuring MacOS defaults. NOTE: A restart is needed"

  stow_dotfiles
  success "Finished stowing dotfiles"

  info "################################################################################"
  info "SSH Key"
  info "################################################################################"
  setup_github_ssh
  success "Finished setting up SSH Key"

  if ! hash rustc &>/dev/null; then
    info "################################################################################"
    info "Rustup Setup"
    info "################################################################################"
    wait_input
    rustup-init
  fi

  success "Done"

  info "System needs to restart. Restart?"

  select yn in "y" "n"; do
    case $yn in
    y)
      sudo shutdown -r now
      break
      ;;
    n) exit ;;
    esac
  done
}

trap cleanup SIGINT SIGTERM ERR EXIT

main
