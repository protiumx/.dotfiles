#!/usr/bin/env zsh

: "$LANG:=\"en_US.UTF-8\""
: "$LANGUAGE:=\"en\""
: "$LC_CTYPE:=\"en_US.UTF-8\""
: "$LC_ALL:=\"en_US.UTF-8\""

export LANG LANGUAGE LC_CTYPE LC_ALL
export GPG_DEFAULT_KEY=1B2B3771
export GPG_TTY=$(tty)

reload() {
  source ~/.zshrc
  source ~/.zshenv
}

function starship-kube() {
  export STARSHIP_KUBE=true
}

jwt-decode() {
  jq -R 'split(".") | .[0:2] | map(@base64d) | map(fromjson)' <<<$1
}

# Linux: sudo cpan Regexp::Debugger
# Macos: sudo perl -MCPAN -e 'install Regexp::Debugger'
# $1 - The input
# $2 - The regex expression
# NOTE: needs Regexp::Debugger module
perlrex() {
  perl -MRegexp::Debugger -E "q{$1} =~ m{$2}"
}

# Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
has-httpgz() {
  encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" &&
    echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
}

# Move files fuzzy find destination
fzmv() {
  mv "$@" $(fd -t d -H | fzf)
}

# Create a new directory and cd it
# $1 - directory name
md() {
  mkdir -p "$1" && cd "$1"
}

# Fzf all folders and cd on selection
cdi() {
  p="$(fd -t d -H | fzf)"
  if [ -n "$p" ]; then
    cd "$p"
  fi
}

# $1 - port number
server() {
  local port="${1:-8000}"
  python3 -m http.server $port
}

# Show package.json scripts with fzf and run selected
npm-run() {
  name=$(jq .scripts package.json | sed '1d;$d' | fzf --height 40% | awk -F ': ' '{gsub(/"/, "", $1); print $1}')
  if [[ -n $scripts ]]; then
    yarn run "$name"
  fi
}

# Retrieve process real memory
# $1 - process id
psmem() {
  ps -o rss= -p "$1" | awk '{ hr=$1/1024; printf "%13.2f Mb\n",hr }' | tr -d ' '
}

# Parse unix epoch to ISO date
epoch() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    date --date "@$1" +"+%Y-%m-%dT%H:%M:%SZ"
  else
    date -r "$1" '+%Y-%m-%dT%H:%M:%SZ'
  fi
}

urldecode() {
  python3 -c "from urllib.parse import unquote; print(unquote('$1'));"
}

urlencode() {
  python3 -c "import urllib.parse; print(urllib.parse.quote_plus('$1'));"
}

# Run jq using fzf and clipboard as source
# $1 - Either a json string or a file path
ijq() {
  if [[ -n "$1" ]]; then
    if [[ -f "$1" ]]; then
      pbcopy <$1
    else
      pbcopy <<<"$1"
    fi
  fi

  # Piping an empty value blocks fzf from using default sources
  echo '' | fzf --print-query --preview-window nohidden --no-height -q "." --preview "pbpaste | jq {q}"
}

# Go to repository root folder
groot() {
  root="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [ -n "$root" ]; then
    cd "$root"
  else
    echo "Not in a git repository"
  fi
}

# Conventional commits helper
ccommit() {
  if [ -z "$3" ]; then
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

# Print commits with URLs to github
gh-logs() {
  local remote="$(git remote -v | awk '/^origin.*\(push\)$/ {print $2}')"
  [[ "$remote" ]] || return
  local user_repo="$(echo "$remote" | perl -pe 's/.*://;s/\.git$//')"
  git log $* --name-status --color | awk "$(
    cat <<AWK
    /^.*commit [0-9a-f]{40}/ {sha=substr(\$2,1,7)}
    /^[MA]\t/ {printf "%s\thttps://github.com/$user_repo/blob/%s/%s\n", \$1, sha, \$2; next}
    /.*/ {print \$0}
AWK
  )" | less -F
}

# Print git remote as http URL
gremote() {
  git config --get remote.origin.url | sed -E 's/(ssh:\/\/)?git@/https:\/\//' | sed 's/com:/com\//' | sed 's/\.git$//' | head -n1
}

# Creates and push a git tag with a template v0.0.0-pre.$USER-<branch>-D-HHmm
alpha-build() {
  local current_branch=$(git branch --show-current | sed 's/\//-/')
  local timestring=$(date +"%d-%H%M")
  local tag_name="v0.0.0-pre.$USER-$current_branch-$timestring"
  if [[ $current_branch =~ "$USER" ]]; then
    tag_name="v0.0.0-pre.$current_branch-$timestring"
  fi

  git tag $tag_name || echo "Failed to create tag $tag_name"
  (git push origin $tag_name && echo -e "\nTag: $tag_name") || echo "Failed to push tag $tag_name"
}

# Print all 256 ANSI colors
ansi-colors() {
  python3 -c "print(''.join(f'\u001b[48;5;{s}m{s.rjust(4)}' + ('\n' if not (int(s)+1) % 8 else '') for s in (str(i) for i in range(256))) + '\u001b[0m')"
}

# Compare json files
jsondiff() {
  delta <(jq --sort-keys . $1) <(jq --sort-keys . $2)
}

# Trigger pin entry for key $GPG_DEFAULT_KEY
gpg-pin() {
  echo "sign" | gpg --sign --default-key $GPG_DEFAULT_KEY &>/dev/null
}

fzf-nvim-files() {
  local oldfiles=($(nvim -u NONE --headless +'lua io.write(table.concat(vim.v.oldfiles, "\n") .. "\n")' +qa))
  local valid_files=()
  for file in "${oldfiles[@]}"; do
    if [[ -f "$file" ]]; then
      valid_files+=("$file")
    fi
  done
  local files=($(printf "%s\n" "${valid_files[@]}" |
    grep -v '\[.*' |
    fzf --multi \
      --preview 'bat -n --color=always --line-range=:500 {} 2>/dev/null || echo "Error previewing file"' \
      --height=70% \
      --layout=default))

  [[ ${#files[@]} -gt 0 ]] && nvim "${files[@]}"
}

# Fuzzy find kubernetes resource and apply an action
kf() {
  local r=$(kubectl get $1 | sed 1d | awk '{print $1}' | fzf --height 40% -q ${2:-""})
  case $3 in
  log)
    klog $1 $r
    ;;

  sh)
    kubectl exec -it $r -- sh
    ;;

  describe)
    kubectl describe $1 $r
    ;;

  pb)
    echo -n "$r" | pbcopy
    echo -e "Copied \e[1;32m\"$r\"\e[0m to clipboard"
    ;;

  *)
    echo "$r"
    ;;
  esac
}

# Kubernetes follow logs since 1m
klog() {
  if [[ "$1" == "deployment" ]]; then
    kubectl logs -f --all-containers=true --since=1m "deployments/$2"
  else
    kubectl logs -f --since 1m $2
  fi
}

# Watch kubernetes resources every 5 seconds. Highlights differences.
kwatch() {
  watch -n 5 -d "kubectl get $1 | grep $2"
}

kube-serv-config() {
  if [ -z "$1" ]; then
    echo "No service supplied. \nUsage: $funcstack[1] <service>"
  else
    kubectl get configmap "$1" \
      -o go-template='{{range $k, $v := .data }}export {{$k}}={{$v}}{{"\n"}}{{end}}' >"$1.config.json"
  fi
}

# View the environment variables of a provided pod
kube-pod-env() {
  if [ -z "$1" ]; then
    echo "No pod supplied. \nUsage: $funcstack[1] <pod_name>"
  else
    kubectl exec "$1" -it -- env
  fi
}

kube-pod-image() {
  kubectl get pod -o jsonpath='{.items[*].spec.containers[*].image}' |
    tr -s '[[:space:]]' '\n' | sort | cut -d'/' -f3 | column -t -s':'
}

# Pack a folder into a .tar.bz2
pack() {
  if [ -z "$1" ]; then
    echo "No directory supplied. \nUsage: $funcstack[1] directory-path"
  elif ! [[ -d $1 ]]; then
    echo "Error: $1 is not a directory."
  else
    tar -cvjSf "$(date "+%F")-$1.tar.bz2" "$1"
  fi
}

# Unpack a .tar.bz2 folder
unpack() {
  if [ -z "$1" ]; then
    echo "No directory supplied. \nUsage: $funcstack[1] directory-path.tar.bz2"
  else
    tar xjf "$1"
  fi
}

brewit() {
  brew update &&
    brew upgrade &&
    brew autoremove &&
    brew cleanup -s &&
    brew doctor
}

docker-clean() {
  docker rm $(docker ps -aq)
}

docker-down() {
  docker stop $(docker ps -a -q)
}

slog() {
  stern --since 1m deployments/$1
}

# print $1 rand bytes in b64
rand() {
  openssl rand -base64 "${1:-10}"
}

################## Aliases ##################

alias cat="bat -p --paging=never --theme='TwoDark'"
alias dc="docker compose"
alias dot="cd ~/.dotfiles && nvim ."
alias duu="dust -b -H -r -X '.git'"
alias e="nvim"
alias gmw="go mod why"
alias icat="wezterm imgcat"
alias tree="eza --tree --level=5 --icons --group-directories-first --color auto"

# Kubernetes
alias k="kubectl"
alias kx="kubectx"
alias k9="k9s -c pod --readonly"
alias kfp="kf pods"
alias kfs="kf services"
alias kfd="kf deployments"
alias kfplog="kf pods '' log"
alias kfdlog="kf deployment '' log"
alias kdc="kubectl describe configmap"
alias kdd="kubectl describe deployment"
alias kdp="kubectl describe pods"
alias kds="kubectl describe svc"
alias kxp="kubectl config get-contexts"
alias kgd="kubectl get deployements"
alias kge="kubectl get events"
alias kgi="kubectl get ingress"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
alias kpf="kubectl port-forward"
alias krrd="kubectl rollout restart deployment"
alias ksd="kubectl scale deployment"

alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias ppath='echo -e ${PATH//:/\\n}'
alias localip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\ -f2"

# Lock the screen macos
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"

# Conventional Commits
alias g="git"
alias gcm="git commit -m"
alias gnv="git commit --no-verify -m"
alias gre="ccommit refactor"
alias gte="ccommit test"
alias gfi="ccommit fix"
alias gfe="ccommit feat"
alias gch="ccommit chore"
alias gst="ccommit style"
alias gci="ccommit ci"
alias gdo="ccommit docs"
alias gmi="ccommit misc"
alias pull="git pull"
alias push="git push"

alias rgv="rg --no-heading --vimgrep"
alias yeet="rm -rf"

alias -g ...='../..'
alias rd=rmdir
alias ls="eza --group-directories-first -G --color auto --hyperlink --icons -a -s type"
alias ll="eza --group-directories-first -l --color always --hyperlink --icons -a -s type"
alias la='ls -lah'
