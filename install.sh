#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

. scripts/utils.sh
. brew_utils/utils.sh
. scripts/apps.sh
. scripts/cli.sh
. scripts/config.sh
. scripts/fonts.sh
. scripts/packages.sh

function cleanup() {
    echo "Finishing"
}

trap cleanup INT

function main() {
  print_green "Starting ..."

  install_xcode_clt
  print_green "Finished installing xcode"
  wait_input

  install_homebrew
  print_green "Finished installing Homebrew"
  wait_input    

  install_packages
  print_green "Finished installing Homebrew packages"
  wait_input

  install_fonts
  print_green "Finished installing fonts"
  wait_input

  install_oh_my_zsh
  chsh -s /bin/zsh
  print_green "Finished installing Oh-my-zsh"
  wait_input

  install_macos_apps
  print_green "Finished macOS apps"
  wait_input

  configure_macos_defaults
  print_green "Finished configuring defaults. NOTE: A restart is needed"
  wait_input

  code_as_default_text_editor
  print_green "Finished setting up vscode as default text editor"
  wait_input

  configure_iterm
  print_green "Finished setting up vscode as default text editor"
  stow_dotfiles
  print_green "Finished stowing dotfiles"
  print_blue "Install NeoVim plugins"
  nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall'

  print_green "Installation finished"
}

main
