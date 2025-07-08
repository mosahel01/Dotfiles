# ~/.zshrc - Clean, Fast, Functional for Oh My Zsh

# ========================
# Environment Setup
# ========================
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"
export QT_QPA_PLATFORM=wayland

# ========================
# Theme Configuration
# ========================
# ZSH_THEME="robbyrussell"  # You can change this to "agnoster" or any other theme if needed
# ZSH_THEME="agnoster"  # You can change this to "agnoster" or any other theme if needed
# ZSH_THEME="daveverwer"  # You can change this to "agnoster" or any other theme if needed
# ZSH_THEME="fishy"  # You can change this to "agnoster" or any other theme if needed
ZSH_THEME="frontcube"  # You can change this to "agnoster" or any other theme if needed
# ZSH_THEME="nanotech"  # You can change this to "agnoster" or any other theme if needed

# ========================
# Add Plugin Paths
# ========================
fpath+=("/usr/share/zsh/plugins/zsh-autosuggestions")
fpath+=("/usr/share/zsh/plugins/zsh-syntax-highlighting")  # Ensure this is correct after installation

# ========================
# Plugins
# ========================
# Use this when Git Cloning Plugins
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions )

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load plugins
# Use these when Installing with Pacman
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # Ensure this path is correct
# source /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh # Add more below to add plugins

bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^j' up-line-or-search
bindkey '^k' down-line-or-search

# ========================
# Prompt (Starship)
# ========================
# eval "$(starship init zsh)"

# ========================
# History Settings
# ========================
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000
setopt APPEND_HISTORY             # Don’t overwrite history
setopt SHARE_HISTORY              # Share history across terminals
setopt HIST_IGNORE_ALL_DUPS       # Remove older duplicate entries
setopt HIST_REDUCE_BLANKS         # Remove superfluous blanks

# Enable ↑ / ↓ search for previous commands
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# ========================
# Completion
# ========================
autoload -Uz compinit && compinit

# Optional Git completion (zsh style)
[[ -f /usr/share/zsh/site-functions/_git ]] && fpath+=(/usr/share/zsh/site-functions)

# ========================
# FZF (Fuzzy Finder)
# ========================
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
fi

if [[ -f /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
fi

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# ========================
# Aliases
# ========================
alias l="eza -l --icons --git -a"
alias ll='eza  -ls --icons--git -h'
alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"
# alias l='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first'
# alias ls='eza --all --long --group --group-directories-first --icons --header --time-style long-iso'
# alias ll='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h'
# alias la='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a'
# alias lla='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l --git -h'

# Common tools
alias cat='bat'
alias grep="grep --color=auto"
alias mkdir="mkdir -pv"
alias SS="sudo systemctl "

# Pain in ASS
alias whatsapp="QT_QPA_PLATFORM=wayland whatsie"

# Shortcuts
alias v='nvim'
alias c='clear'
alias e='exit'
alias y='yazi'

# # File/image viewer
# alias img="nsxiv ."
# alias gif="nsxiv -a"

# Package management
alias ps='sudo pacman -S'
alias pss='pacman -Ss'
alias ys='yay -S'
alias yss='yay -Ss'
alias prunsc='sudo pacman -Rns'
alias yrunsc='yay -Rns'

alias H="cd ~/.config/hypr/ && nvim ."

# ========================
# Optional Settings
# ========================
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to change the auto-update behavior
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz
