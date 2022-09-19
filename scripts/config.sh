code_as_default_text_editor() {
  info "Setting up VSCode as default editor for common extensions"
  local extensions=(
    ".c"
    ".cpp"
    ".js"
    ".jsx"
    ".ts"
    ".tsx"
    ".json"
    ".md"
    ".sql"
    ".html"
    ".css"
    ".scss"
    ".sass"
    ".py"
    ".sum"
    ".rs"
    ".go"
    ".sh"
    ".log"
    ".toml"
    ".yml"
    ".yaml"
    "public.plain-text"
    "public.unix-executable"
    "public.data"
  )

  for ext in "${extensions[@]}"; do
    duti -s com.microsoft.VSCode $ext all
  done
}

setup_github_ssh() {
  info "Using $SSH_PASSPHRASE"
  ssh-keygen -t ed25519 -C $SSH_PASSPHRASE

  info "Adding ssh key to keychain"
  ssh-add -K ~/.ssh/id_ed25519

  info "Remember add ssh key to github account 'pbcopy < ~/.ssh/id_ed25519.pub'"
}

stow_dotfiles() {
  local files=(
    ".aliases"
    ".config/starship.toml"
    ".gitconfig"
    ".profile*"
    ".vimrc"
    ".zshrc"
    ".zprofile"
  )
  local folders=(
    ".config/fd"
    ".config/kitty"
    ".config/nvim"
    ".config/ripgrep"
    ".git-templates/hooks"
    ".ssh"
  )
  info "Removing existing config files"
  for f in "${files[@]}"; do
    rm -f "$HOME/$f" || true
  done

  # Create the folders to avoid symlinking folders
  for d in "${folders[@]}"; do
    rm -rf "${HOME:?}/$d" || true
    mkdir -p "$HOME/$d"
  done

  local dotfiles="fd git kitty nvim ripgrep ssh starship vim zsh"
  info "Stowing: $dotfiles"
  stow -d stow --verbose 1 --target $HOME $dotfiles
}
