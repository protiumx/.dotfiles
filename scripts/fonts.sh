fonts=(
	font-fira-code
)

install_fonts() {
	info "Installing fonts..."
	brew tap homebrew/cask-fonts
	install_brew_casks "${fonts[@]}"
}
