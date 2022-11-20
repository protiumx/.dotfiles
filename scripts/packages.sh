taps=(
  hashicorp/tap
  helm/tap
  helix-editor/helix
  homebrew/cask
  homebrew/cask-fonts
  homebrew/core
  vmware-tanzu/carvel
)

packages=(
	bat                      #  https://github.com/sharkdp/bat
	bandwhich                #  https://github.com/imsnif/bandwhich
	bottom                   #  https://github.com/ClementTsang/bottom
	cmake
	ctags
	curl
	duti                     #  https://github.com/moretension/duti
	exa                      #  https://github.com/ogham/exa
	fzf                      #  https://github.com/junegunn/fzf
	fd                       #  https://github.com/sharkdp/fd
	gettext
	gh
	go
  grpcurl                  #  https://github.com/fullstorydev/grpcurl
	hashicorp/tap/terraform
	helm
	httpie                   #  https://github.com/httpie/httpie
	imagemagick
	jq
	k9s                      #  https://github.com/derailed/k9s
	kubernetes-cli
	lazydocker               #  https://github.com/jesseduffield/lazydocker
  lf                       #  https://github.com/gokcehan/lf
	libpq
	macpass                  #  https://macpassapp.org/
	minikube
	node
	nvm
	nmap
	openjdk
	openssl
	postgresql
	procs                    #  https://github.com/dalance/procs/
	python3
	protobuf
	ripgrep                  #  https://github.com/BurntSushi/ripgrep
	rustup
	shellcheck
	stow
	tealdeer                 #  https://github.com/dbrgn/tealdeer
	telnet
	websocat                 #  https://github.com/vi/websocat
	yarn
	wget
	zsh
	zsh-autosuggestions
	zsh-syntax-highlighting
	zoxide                   #  https://github.com/ajeetdsouza/zoxide
)

install_packages() {
  info "Configuring taps"
  apply_brew_taps "${taps[@]}"

  info "Installing packages..."
  install_brew_formulas "${packages[@]}"

  info "Cleaning up brew packages..."
  brew cleanup
}
