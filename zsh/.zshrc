# ==========================================
# ORPHIC ZSH CONFIG
# ==========================================

# Performance: Compile zshrc if needed
if [[ ! -f ~/.zshrc.zwc ]] || [[ ~/.zshrc -nt ~/.zshrc.zwc ]]; then
    zcompile ~/.zshrc
fi

# ==========================================
# CORE SETTINGS
# ==========================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# Directory Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Completion
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Misc Options
setopt CORRECT
setopt NO_BEEP
setopt PROMPT_SUBST

# ==========================================
# KEYBINDINGS
# ==========================================

bindkey -v  # Vi mode
export KEYTIMEOUT=1

# Better history search
bindkey '^R' history-incremental-search-backward
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# Edit command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-lin:w

# ==========================================
# PROMPT - MINIMAL & SQUARED
# ==========================================

# ==========================================
# ENVIRONMENT
# ==========================================

# Core
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R"

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Path
typeset -U path
path=(
    $HOME/.local/bin
    $HOME/bin
    /usr/local/bin
    $path
)

# ==========================================
# ALIASES - ESSENTIAL & FUNCTIONAL
# ==========================================

# Core Utils
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lAh'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# System
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'

# Editor
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'
alias gcl='git clone'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlogs='docker logs -f'
alias dprune='docker system prune -af'

# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kd='kubectl describe'
alias kl='kubectl logs -f'
alias kex='kubectl exec -it'
alias kctx='kubectl config use-context'

# AWS
alias aws-profile='export AWS_PROFILE=$(aws configure list-profiles | fzf)'
alias aws-whoami='aws sts get-caller-identity'
alias aws-regions='aws ec2 describe-regions --query "Regions[].RegionName" --output text'

# Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tff='terraform fmt -recursive'
alias tfv='terraform validate'

# Python
alias py='python'
alias pip='pip3'
alias venv='python -m venv'
alias activate='source venv/bin/activate'

# Security Tools
alias nmap-quick='nmap -T4 -F'
alias nmap-full='nmap -T4 -A -v'
alias ports='netstat -tulanp'
alias listening='ss -tuln'

# Tmux
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'

# System Monitoring
alias cpu='ps aux | sort -nr -k 3 | head -10'
alias mem='ps aux | sort -nr -k 4 | head -10'
alias myip='curl -s ifconfig.me'

# Safety
alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'

# ==========================================
# FUNCTIONS
# ==========================================

# Quick directory creation and navigation
mkcd() { mkdir -p "$1" && cd "$1"; }

# Extract archives
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.tar.xz)    tar xJf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick note taking
note() {
    local notes_dir="$HOME/garden/inbox"
    mkdir -p "$notes_dir"
    $EDITOR "$notes_dir/$(date +%Y-%m-%d).md"
}

# Find large files
largest() {
    du -ah ${1:-.} | sort -rh | head -n ${2:-20}
}

# Port check
port() {
    sudo lsof -i :$1
}

# Quick HTTP server
serve() {
    python -m http.server ${1:-8000}
}

# ==========================================
# OPTIONAL: LOAD LOCAL OVERRIDES
# ==========================================

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

