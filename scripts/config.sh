setup_github_ssh() {
  if [ -z "${SSH_PASSPHRASE}" ]; then
    echo "SSH_PASSPHRASE not set"
  else
    info "Using $SSH_PASSPHRASE"
    ssh-keygen -t ed25519 -C "$SSH_PASSPHRASE"

    info "Adding ssh key to keychain"
    ssh-add -K ~/.ssh/id_ed25519

    info "Remember add ssh key to github account 'pbcopy < ~/.ssh/id_ed25519.pub'"
  fi
}

stow_dotfiles() {
  local files=(
    ".aliases"
    ".config/starship.toml"
    ".gitconfig"
    ".jq"
    ".profile*"
    ".psqlrc"
    ".vimrc"
    ".zshrc"
    ".zshenv"
    ".zprofile"
  )
  local directories=(
    ".config/amethyst"
    ".config/fd"
    ".config/git"
    ".config/nvim"
    ".config/ripgrep"
    ".config/vim"
    ".config/wezterm"
    ".config/yazi"
    ".gnupg"
    ".ssh"
  )

  info "Removing existing config files"
  for f in "${files[@]}"; do
    rm -f "$HOME/$f" || true
  done

  info "Removing existing config directories"
  for d in "${directories[@]}"; do
    rm -rf "${HOME:?}/$d" || true
    # Create the folders to avoid symlinking folders
    mkdir -p "$HOME/$d"
  done

  # shellcheck disable=SC2155
  local to_stow="$(find stow -maxdepth 1 -type d -mindepth 1 -not -path "library" | awk -F "/" '{print $NF}' ORS=' ')"
  info "Stowing: $to_stow"

  read -p "Are you sure? " -n 1 -r
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    stow -d stow --verbose 1 --target "$HOME" "$to_stow"
    # set permissions
    chmod a+x ~/.git-templates/hooks/pre-commit

    if [[ "$OSTYPE" == "darwin"* ]]; then
      stow -d stow --verbose 1 --target "$HOME/Library/Application Support/" library
    fi
  fi
}
