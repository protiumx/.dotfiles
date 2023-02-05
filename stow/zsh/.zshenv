# Functions

cheat() {
  curl -s "cheat.sh/$1";
}

# Show package.json scripts with fzf and run selected
pkgrun() {
  name=$(jq .scripts package.json | sed '1d;$d' | fzf --height 40% | awk -F ': ' '{gsub(/"/, "", $1); print $1}')
  if [[ -n $scripts ]]; then
    yarn run "$name"
  fi
}

# Jump to folder (zoxide) and open nvim.
# NOTE: nvim plug will set the root folder properly if a .git folder exists
zv() {
 z "$1"
 nvim .
}

# Retrieve process real memory
psrm() {
  ps -o rss= -p "$1" | awk '{ hr=$1/1024; printf "%13.2f Mb\n",hr }' | tr -d ' ';
}

# Watch process real memory
psrml() {
  while true;
  do
    psrm "$1";
    sleep 1;
  done
}

# Go to repository root folder
groot() {
  root="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [ -n "$root" ]; then
    cd "$root";
  else
    echo "Not in a git repository"
  fi
}

gcommit() {
  if [ -z "$3" ]
  then
    git commit -m "$1: $2"
  else
    git commit -m "$1($2): $3"
  fi
}

# Pretty git log
glog() {
  git log --graph --abbrev-commit --decorate --all \
    --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) \
    - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"
}

# Print git remote
gremote() {
  git remote -v | grep fetch | awk '{print $2}' | sed 's/git@/https:\/\//' | sed 's/com:/com\//' | sed 's/\.git$//' | head -n1
}

mkcd(){
  mkdir -p "$1" && cd "$1" || exit
}

# Print all 256 ANSI colors
ansi_colors() {
  python3 -c "print(''.join(f'\u001b[48;5;{s}m{s.rjust(4)}' + ('\n' if not (int(s)+1) % 8 else '') for s in (str(i) for i in range(256))) + '\u001b[0m')"
}

# Fzf all folders and cd on selection
cdi() {
  p="$(fd -t d -H | fzf)"
  if [ -n "$p" ]; then
    cd "$p"
  fi
}

# Excluded dirs are set in ../fd/ignore
export FZF_DEFAULT_COMMAND="fd -d 1 --hidden --follow --color=never --strip-cwd-prefix"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --prompt ' ' --bind 'ctrl-p:preview(bat {})' --preview-window hidden --no-info --color 'gutter:-1,hl+:#82aaff,hl:#82aaff,bg+:-1,pointer:#82aaff'"
export FZF_COMPLETION_OPTS=$FZF_DEFAULT_OPTS

_fzf_compgen_path() {
  fd -d 1 --strip-cwd-prefix --hidden --follow --exclude ".git/" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd -d 1 --strip-cwd-prefix --type d --hidden --follow --exclude ".git/" . "$1"
}

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rg"

# Aliases
alias tree="exa --tree --level=5 --icons --group-directories-first --color auto"

alias lt="dust -b -H -r -X '.git'"

alias yw="yarn workspace"
alias cat="bat -p --paging=never --theme='TwoDark'"

# Conventional Commits
alias gcm="git commit -m"
alias gnv="git commit --no-verify -m"
alias gre="gcommit refactor"
alias gte="gcommit test"
alias gfi="gcommit fix"
alias gfe="gcommit feat"
alias gch="gcommit chore"
alias gst="gcommit style"
alias gci="gcommit ci"
alias gdo="gcommit docs"
alias gmi="gcommit misc"

alias dc="docker compose"
alias kc="kubectl"
alias k9="k9s"
alias icat="kitty +kitten icat --align left"
# Create 5 random passwords
alias mkpwd="xkcdpass --count=5 --acrostic=\"chaos\" -C \"first\" -R --min=5 --max=6 -D \"#@^&~_-;\""
alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'
# Serve files in current dir with python http server
alias serv="python3 -m http.server"
