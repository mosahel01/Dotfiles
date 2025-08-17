# ~/.bashrc - Minimal functional config

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

shopt -s autocd  # just type dir name to cd

case $- in *i*) ;; *) return ;; esac  # only interactive shells

# Simple colored prompt: user@host cwd$
PS1='\[\e[32m\]\u@\h \[\e[34m\]\w\[\e[0m\] \$ '

# History config: no duplicates, append, ctrl-up/down to search history prefix
HISTCONTROL=ignoredups:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Bash completion (if available)
[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion

# Load git completion if present
[[ -f /usr/share/bash-completion/completions/git ]] && source /usr/share/bash-completion/completions/git

# FZF fuzzy finder bindings & completion (if installed)
[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# Aliases for quick commands
alias l='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
# alias ls='eza --all --long --group --group-directories-first --icons --header --time-style long-iso'
alias ls='eza --group --long --group-directories-first --icons --header --time-style long-iso'
alias ll='eza --color=always --long --all --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h'
alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias ltree='eza --tree --all --level=3 --long --icons --git'
alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l --git -h'

alias cat='bat'
alias mkdir='mkdir -pv'
alias grep="grep --color=auto"
alias cp="cp -i"
alias v='nvim'
alias c='clear'
alias e="exit"
alias y="yazi"

# Package management shortcuts for pacman & paru
alias ps='sudo pacman -S'
alias pss='pacman -Ss'
alias ys='paru -S'
alias yss='paru -Ss'
alias prunsc='sudo pacman -Rns'
alias yrunsc='paru -Rns'

alias H="cd ~/.config/hypr && nvim ."
alias Z="nvim ~/.bashrc && source ~/.bashrc"

# Optional: vim mode
set -o vi


# Example function: quick pdf downloader via sci-hub (commented as example)
# shdl() { curl -o "$(curl -s https://sci-hub.tw/"$1" | grep location.href | grep -o 'http.*pdf')" ;}
