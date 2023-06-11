#!/usr/bin/env zsh

# Functions

cheat() {
  curl -s "cheat.sh/$1";
}

# Move files fuzzy find destination
fmv() {
  mv "$@" $(fd -t d -H | fzf)
}

# Show package.json scripts with fzf and run selected
pkgrun() {
  name=$(jq .scripts package.json | sed '1d;$d' | fzf --height 40% | awk -F ': ' '{gsub(/"/, "", $1); print $1}')
  if [[ -n $scripts ]]; then
    yarn run "$name"
  fi
}

# Jump to folder (zoxide) and open nvim.
zv() {
 z "$1" && nvim .
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

# Run jq using fzf and clipboard as source
ijq() {
  echo '' | fzf --print-query --preview-window nohidden --no-height --preview "${1-pbpaste} | jq {q}"
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

# Conventional commits helper
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
  git config --get remote.origin.url | sed -E 's/(ssh:\/\/)?git@/https:\/\//' | sed 's/com:/com\//' | sed 's/\.git$//' | head -n1
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

# Compare json files
jcmp() {
  delta <(jq --sort-keys . $1) <(jq --sort-keys . $2)
}

# Fuzzy find kubernetes resource and apply an action
kf() {
  local r=$(kubectl get $1 | sed 1d | awk '{print $1}' | fzf --height 40% -q ${2:-""})
  local action="${3:-pb}"

  echo "Using $1 $r"

  case $action in
    log)
      echo "Fetching logs"
      klog $1 $r
      ;;

    sh)
      echo "Running exec"
      kubectl exec -it $r -- sh
      ;;

    describe)
      echo "Kube"
      kubectl describe $1 $r
      ;;

    pb)
      echo -n "$r" | pbcopy
      echo -e "Copied \e[1;32m\"$r\"\e[0m to clipboard"
      ;;
  esac
}

# Kubernetes follow logs since 1m
klog() {
  if  [[ "$1" == "deployment" ]]; then
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
      -o go-template='{{range $k, $v := .data }}export {{$k}}={{$v}}{{"\n"}}{{end}}'
  fi
}

# View the envionment variables of a provided pod
kube-pod-env() {
  if [ -z "$1" ]; then
    echo "No pod supplied. \nUsage: $funcstack[1] <pod_name>"
  else
    kubectl exec "$1" -it -- env
  fi
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

dstop-all() {
  docker stop $(docker ps -aq)
}

drm-all() {
  docker rm $(docker ps -aq)
}

# Aliases
alias cat="bat -p --paging=never --theme='TwoDark'"
alias dc="docker compose"
alias dot="cd ~/.dotfiles && nvim"
alias e="nvim"
alias icat="wezterm imgcat"
alias lt="dust -b -H -r -X '.git'"
alias tree="exa --tree --level=5 --icons --group-directories-first --color auto"
alias yw="yarn workspace"

# Kubernetes
alias kx="kubectx"
alias k="kubectl"
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

alias kgctx="kubectl config get-contexts"
alias kgcj="kubectl get cronjob"
alias kgconf="kubectl get configmap"

alias kgd="kubectl get deployements"
alias kge="kubectl get events"
alias kgi="kubectl get ingress"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
# List pods images
alias kgpv="kgp -o jsonpath='{.items[*].spec.containers[*].image}' | tr -s '[[:space:]]' '\n' | sort | cut -d'/' -f3 | column -t -s':' | uniq -c | fzf --height 40%"

alias kpf="kubectl port-forward"
alias krrd="kubectl rollout restart deployment"
alias ksd="kubectl scale deployment"

# Create 5 random passwords
alias mkpwd="xkcdpass --count=5 --acrostic=\"chaos\" -C \"first\" -R --min=5 --max=6 -D \"#@^&~_-;\""
alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'
# Serve files in current dir with python http server
alias serv="python3 -m http.server"
# Reload shell
alias reload="exec $SHELL -l"
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
alias localip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\  -f2"
# Lock the screen
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"

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
