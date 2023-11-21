install_python_packages() {
	local pip_packages=(
		black
		xkcdpass
	)

	for p in "${pip_packages[@]}"; do
		if pip3 show "$p" >/dev/null; then
			warn "Package $p is already installed"
		else
			info "Installing package < $p >"
			pip3 install "$p"
		fi
	done
}

install_go_tools() {
	declare -A tools=(
		[delve]="github.com/go-delve/delve/cmd/dlv@latest"
		[shfmt]="mvdan.cc/sh/v3/cmd/shfmt@latest"
	)

	for tool in "!${tools[@]}"; do
		if ! command -v "$tool" &>/dev/null; then
			info "Installing go tool < $tool >"
			go install "${tools[$tool]}"
		else
			warn "$tool is already installed"
		fi
	done
}

install_rust_tools() {
	source "$HOME/.cargo/env"

	if ! command -v rust-analyzer &>/dev/null; then
		info "Installing rust-analyzer"
		brew install rust-analyzer
	fi

	if ! cargo audit --version &>/dev/null; then
		info "Installing cargo-audit"
		cargo install cargo-audit --features=fix
	fi

	if ! cargo edit --version &>/dev/null; then
		info "Installing cargo-edit"
		cargo install cargo-edit
	fi

	if ! cargo nextest --version &>/dev/null; then
		info "Installing cargo-nextest"
		cargo install cargo-nextest
	fi

	if ! cargo fmt --version &>/dev/null; then
		info "Installing rustfmt"
		rustup component add rustfmt
	fi

	if ! cargo clippy --version &>/dev/null; then
		info "Installing clippy"
		rustup component add clippy
	fi
}
