#!/usr/bin/env bash

set -o errexit

REPO_URL=https://github.com/protiumx/.dotfiles.git
REPO_PATH="$HOME/.dotfiles"

reset_color=$(tput sgr 0)

info() {
	printf "%s[*] %s%s\n" "$(tput setaf 4)" "$1" "$reset_color"
}

success() {
	printf "%s[*] %s%s\n" "$(tput setaf 2)" "$1" "$reset_color"
}

err() {
	printf "%s[*] %s%s\n" "$(tput setaf 1)" "$1" "$reset_color"
}

warn() {
	printf "%s[*] %s%s\n" "$(tput setaf 3)" "$1" "$reset_color"
}

install_xcode() {
	if xcode-select -p >/dev/null; then
		warn "xCode Command Line Tools already installed"
	else
		info "Installing xCode Command Line Tools..."
		xcode-select --install
		sudo xcodebuild -license accept
	fi
}

install_homebrew() {
	export HOMEBREW_CASK_OPTS="--appdir=/Applications"
	if hash brew &>/dev/null; then
		warn "Homebrew already installed"
	else
		info "Installing homebrew..."
		sudo --validate # reset `sudo` timeout to use Homebrew install in noninteractive mode
		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi
}

info "####### dotfiles #######"
read -p "Press enter to start:"
info "Bootstraping..."

install_xcode
install_homebrew

info "Installing Git"
brew install git

info "Cloning .dotfiles repo from $REPO_URL into $REPO_PATH"
git clone "$REPO_URL" "$REPO_PATH"

info "Change path to $REPO_PATH"
cd "$REPO_PATH" >/dev/null

./install.sh
