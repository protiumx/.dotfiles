function configure_macos_defaults() {
  print_blue "Configuring MacOS default settings"
  # Show hidden files inside the finder
  defaults write com.apple.Finder "AppleShowAllFiles" -bool true
  # Do not show warning when changing the file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  # Show path bar
  defaults write com.apple.finder ShowPathbar -bool true
  # Have the Dock show only active apps
  defaults write com.apple.dock static-only -bool true
  # Set Dock autohide
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock largesize -float 128
  defaults write com.apple.dock "minimize-to-application" -bool true
  defaults write com.apple.dock tilesize -float 32
  # Secondary click in external mouse
  defaults write com.apple.AppleMultitouchMouse MouseButtonMode -string "TwoButton"
}

function code_as_default_text_editor() {
  print_blue "Setting up VSCode as default editor for common extensions"
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
  for ext in $extensions; do
    duti -s com.microsoft.VSCode $ext all
  done
}

function setup_github_ssh() {
  read -p 'github email: ' email
  ssh-keygen -t ed25519 -C $email
  print_blue "Adding ssh key to keychain"
  ssh-add -K ~/.ssh/id_ed25519
  print_blue "Remember add ssh key to github account 'pbcopy < ~/.ssh/id_ed25519.pub'"
}

function stow_dotfiles() {
  local files=(
    ".profile*"
    ".zprofile"
    ".gitconfig"
    ".aliases"
    ".zshrc"
    ".p10k.sh"
  )
  local folders=(
    ".config/nvim"
    ".config/kitty"
    ".git-templates/hooks"
    ".ssh"
  )
  print_blue "Removing existing config files"
  for f in $files; do
    rm -f "$HOME/$f" || true
  done

  # Create the folders to avoid stowing the whole folders
  for d in $folders; do
    rm -rf "$HOME/$d" || true
    mkdir "$HOME/$d"
  done

  print_blue "Stowing ssh, zsh, git, kitty and nvim"
  cd stow && stow --verbose 1 --target $HOME zsh ssh git nvim kitty && cd ..
}
