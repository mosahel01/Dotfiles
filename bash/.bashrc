### ------------------------------
### Environment
### ------------------------------

# Path
export PATH="./bin:$HOME/.local/bin:$PATH"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

### ------------------------------
### Shell Behavior
### ------------------------------

shopt -s autocd # type dir name to cd
shopt -s nocaseglob # case-insensitive file globbing

case $- in *i*) ;; *) return ;; esac # only interactive shell

# History
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
PMROMPT_COMMAND="history -a; $PROMPT_COMMAND"
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Autocompletion
if [[ ! -v BASH_COMPLETION_VERSINFO && -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

# Vi-style editing
set -o vi

# Prompt
force_color_prompt=yes
color_prompt=yes
PS1='\[\e[32m\]\u@\h \[\e[34m\]\w\[\e[0m\] \$ '

# Key bindings
bind 'TAB:menu-complete'                   # cycle forward
bind '"\e[Z":menu-complete-backward'       # cycle backward
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'


### ------------------------------
### Readline (Input Behavior)
### ------------------------------

bind 'set colored-stats on'
bind 'set completion-prefix-display-length 2'
bind 'set completion-query-items 200'
bind 'set mark-symlinked-directories on'
bind 'set match-hidden-files off'
bind 'set page-completions off'
bind 'set show-all-if-unmodified on'
bind 'set skip-completed-text on'
bind 'set visible-stats on'

### ------------------------------
### Aliases
### ------------------------------

# File system
alias ls='eza'
alias l='ls -l'
alias la='ls -a'
alias ll='ls -al'
alias lt='ls --tree --level=2'
alias ltree='ls --tree --level=3'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias v='nvim'
alias n='nvim'
alias c='clear'
alias e='exit'
alias y='yazi'
alias cat='bat'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias cp='cp -i'

# Config shortcuts
alias H='cd ~/.config/hypr && nvim .'
alias N='cd ~/.config/nvim && nvim .'
alias J='cd ~/Documents/Java && nvim .'
alias Z='nvim ~/.bashrc && source ~/.bashrc'

# Git
alias gs='git status'
alias gm='git commit -m'
alias ga='git add'
alias gp='git push -u origin main'

# Tmux
alias tn='tmux new -s '          # new session
alias ta='tmux attach'           # attach latest
alias tt='tmux attach -t '       # attach specific
alias ts='tmux ls'               # list sessions
alias tk='tmux kill-session -t ' # kill by name

# Pacman / AUR
alias ps='sudo pacman -S'
alias pss='pacman -Ss'
alias prns='sudo pacman -Rns'
alias ys='paru -S'
alias yss='paru -Ss'
alias yrns='paru -Rns'


### ------------------------------
### Functions
### ------------------------------

# Open files with default program
open() { xdg-open "$@" >/dev/null 2>&1 & }

# # Smart nvim (open file(s) or current dir)
# n() { if [ $# -eq 0 ]; then nvim .; else nvim "$@"; fi; }

# Fuzzy find & preview (open in nvim on Enter)
alias ff="fzf --preview 'bat --style=numbers --color=always {}' --bind 'enter:become(nvim {})'"

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# Video transcoding
transcode-video-1080p() {
    ffmpeg -i "$1" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "${1%.*}-1080p.mp4"
}
transcode-video-4K() {
    ffmpeg -i "$1" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "${1%.*}-optimized.mp4"
}

# PNG → JPG (good for wallpapers)
transcode-png2jpg() {
    magick "$1" -quality 95 -strip "${1%.*}.jpg"
}


### ------------------------------
### External Sources
### ------------------------------

# Custom/Modular dotfiles
# [[ -f ~/Dotfiles/bin/.local/bin/bash/rc ]] && source ~/Dotfiles/bin/.local/bin/bash/rc
