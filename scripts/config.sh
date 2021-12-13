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

function set_vscode_as_default_editor() {
  print_blue "setting up VS Code as default editor for common extensions"
  local extensions=(
    ".c"
    ".cpp"
    ".js"
    ".jsx"
    ".ts"
    ".tsx"
    ".json"
    ".mod"
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

function configure_iterm() {
  if [[ ! -f ~/Library/Application\ Support/iTerm2/DynamicProfiles/iTermProfiles.json ]]; then
    print_blue "Copying iTerm2 profiles..."
    cp iTermProfiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/
  else
    print_yellow "iTerm2 custom profile is already installed"
  fi
}

function stow_dotfiles() {
  print_blue "Removing default config"
  rm ~/.profile ~/.zprofile ~/.gitconfig ~/.aliases ~/.zshrc
  print_blue "Stowing zsh, git, and nvim"
  cd stow && stow -vSt ~ zsh git nvim && cd ..
}
