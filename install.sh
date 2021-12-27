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

function cleanup() {
    echo "Finishing"
}

function wait_input() {
  read -p "Press enter to continue: "
}

trap cleanup EXIT

function main() {
  print_green "Starting ..."

  print_blue "======= xCode ======="
  wait_input
  install_xcode_clt
  print_green "Finished installing xCode"

  print_blue "======= Homebrew ======="
  wait_input
  install_homebrew
  print_green "Finished installing Homebrew"

  print_blue "======= Homebrew packages ======="
  wait_input
  install_packages
  print_green "Finished installing Homebrew packages"

  print_blue "======= Homebrew Fonts ======="
  wait_input
  install_fonts
  print_green "Finished installing fonts"

  print_blue "======= Oh-my-zsh ======="
  wait_input
  install_oh_my_zsh
  print_green "Finished installing Oh-my-zsh"

  install_zsh_plugins
  print_green "Finished installing Oh-my-zsh plugins"

  print_blue "======= MacOS Apps ======="
  wait_input
  install_macos_apps
  print_green "Finished installing macOS apps"

  print_blue "======= NeoVim ======="
  wait_input
  install_neovim
  print_green "Finished installing neovim"

  print_blue "======= Configuration ======="
  wait_input
  setup_osx
  print_green "Finished configuring MacOS defaults. NOTE: A restart is needed"
  code_as_default_text_editor
  print_green "Finished setting up VSCode as default text editor"
  stow_dotfiles
  print_green "Finished stowing dotfiles"

  print_blue "======= SSH Key ======="
  setup_github_ssh
  print_green "Finished setting up SSH Key"

  print_blue "======= NeoVim Plugins ======="
  wait_input
  # Only load the plugins files
  nvim -u ~/.config/nvim/plugins.vim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall'
  print_green "Finished installing nvim plugins"

  print_blue "======= Rust Setup ======="
  wait_input
  rustup-init

  print_blue "Restarting"
  wait_input
  sudo shutdown -r now
}

main
