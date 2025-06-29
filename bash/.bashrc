# ~/.bashrc - Clean, Fast, Functional

# ========================
# Environment Setup
# ========================
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

eval "$(starship init bash)"
shopt -s autocd # Allows cd into directory merely by typing the directory name.

# Only run for interactive shells
case $- in
    *i*) ;;
    *) return ;;
esac

# ========================
# Prompt
# ========================
PS1='\[\e[32m\]\u@\h \[\e[34m\]\w\[\e[0m\] \$ '

# ========================
# Bash History Settings
# ========================
HISTCONTROL=ignoredups:erasedups
# HISTSIZE= HISTFILESIZE= # Infinite history
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# History search with ↑ / ↓
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# ========================
# Bash Completion
# ========================
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

# Git completion (optional, for extra git autocomplete)
[[ -f /usr/share/bash-completion/completions/git ]] && \
    source /usr/share/bash-completion/completions/git

# Yazi completion
[[ -f "$HOME/.local/share/bash-completion/yazi" ]] && \
    source "$HOME/.local/share/bash-completion/yazi"

# ========================
# FZF (Fuzzy Finder)
# ========================
if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
    source /usr/share/fzf/key-bindings.bash
fi

if [[ -f /usr/share/fzf/completion.bash ]]; then
    source /usr/share/fzf/completion.bash
fi

# FZF options
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# ========================
# Aliases
# ========================


alias l='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
alias ls='eza --all --long --group --group-directories-first --icons --header --time-style long-iso'
alias ll='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h'
alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l --git -h'



## Common tools
# alias vim='nvim'
alias cat='bat'
alias grep="grep --color=auto"
alias mkdir="mkdir -pv"
alias SS="sudo systemctl "


alias v='nvim'
alias c='clear'
alias e='exit'
alias y='yazi'

## File/image viewer
alias img="nsxiv ."
alias gif="nsxiv -a"

## Package management
alias ps='sudo pacman -S'
alias pss='pacman -Ss'
alias ys='yay -S'
alias yss='yay -Ss'
alias prunsc='sudo pacman -Rns'
alias yrunsc='yay -Rns'

## Config shortcuts
alias bashconfig='nvim ~/.bashrc'
alias H='cd ~/.config/awesome/ && nvim .'

# shdl() { curl -o $(curl -s https://sci-hub.tw/"$@") | grep location.href | grep -o http.*pdf) ;}  }
