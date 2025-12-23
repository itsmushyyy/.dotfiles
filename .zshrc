# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	git
	docker
	kubectl
	python
	golang
	rust
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# Aliases
alias ll='exa --icons'
alias ll='exa -la --icons'
alias cat='bat'
alias vim='nvim'
alias vi='nvim'

alias nmap-quick='nmap -sV -T4'
alias nmap-full='nmap -sS -sV -O -p- -T4'
alias myip='curl ifconfig.me'

alias dps='docker ps'
alias dimg='docker images'
alias dstop='docker stop $(docker ps -aq)'

alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

alias venv='python -m venv venv && source venv/bin/activate'

alias ctf='cd ~/CTF'
alias lab='cd ~/Lab'

# Environment variables
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$PATH"
export HISTSIZE=10000
export SAVEHIST=10000


source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
