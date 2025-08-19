# ~/.bashrc - Minimal functional config

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

shopt -s autocd  # just type dir name to cd
shopt -s nocaseglob # case-insensitiv file globbing

case $- in *i*) ;; *) return ;; esac  # only interactive shells

# Completion & highlighting
# Enable programmable completion
[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion

# Enable Git completion if present
[[ -f /usr/share/bash-completion/completions/git ]] && source /usr/share/bash-completion/completions/git

# Case-insensitive completion
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'                   # cycle through opts on tab
bind '"\e[Z":TAB:menu-complete-backward'   # backward cycle

# Prompt
PS1='\[\e[32m\]\u@\h \[\e[34m\]\w\[\e[0m\] \$ '

# History
HISTCONTROL=ignoredups:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# FZF fuzzy finder
[[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# Aliases
alias l='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
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

alias window="clear && nitch "

# Package management shortcuts
alias ps='sudo pacman -S'
alias pss='pacman -Ss'
alias ys='paru -S'
alias yss='paru -Ss'
alias prunsc='sudo pacman -Rns'
alias yrunsc='paru -Rns'

alias H="cd ~/.config/hypr && nvim ."
alias N="cd ~/.config/nvim && nvim ."
alias Z="nvim ~/.bashrc && source ~/.bashrc"

# Git
alias gs="git status"
alias gm="git commit -m "
alias ga="git add "
alias gp="git push -u origin main"

# Optional: vim mode
set -o vi

# # FZF fuzzy finder
# [[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
# [[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

# # Load fzf if available
# if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
#     source /usr/share/fzf/key-bindings.bash
#     source /usr/share/fzf/completion.bash
#     # Use fd (faster and respects .gitignore)
#     if command -v fd >/dev/null; then
#         export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
#         export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#         export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
#     else
#         export FZF_DEFAULT_COMMAND='find . -type f 2>/dev/null'
#         export FZF_ALT_C_COMMAND='find . -type d 2>/dev/null'
#     fi
#     # FZF default options (preview enabled)
#     export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'cat --color=always --style=numbers --line-range=:500 {}'"
#     # Enhanced cd with fzf
#     fzf_cd() {
#         local dir
#         dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
#     }
#     bind -x '"\ec": "fzf_cd"'
# fi
