# Environment Setup, Must have
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="$EDITOR"
export GTK_THEME=Adwaita:dark

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml



# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/mos/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install


# autoload -U colors && colors
# setopt promptsubst
# PS1=' 
# $ '
# # PS1='%{$fg[cyan]%}%c%{$reset_color%} $ '

# Alias
alias gs="git status"
alias ga="git add "
alias gm="git commit -m "
alias gp="git push -u origin main "

alias y="yazi"
alias c="clear"
alias e="exit"
alias v="nvim"

alias ps="sudo pacman -S "
alias pss="pacman -Ss "
alias prns="sudo pacman -Rns " # Runsc does not make sense
alias ys="paru -S "
alias yss="paru -Ss "
alias yrns="paru -Rns "

alias H="cd ~/.config/hypr/ && nvim ."
alias N="cd ~/.config/nvim/ && nvim ."
alias J='cd ~/Programming/Java/ '
alias Z="nvim ~/.zshrc && source ~/.zshrc"

alias ts='tmux ls'
alias tt='tmux attach -t ' # tmux attach -t my-other-session
alias ta='tmux attach '


# LSD
alias ls='lsd --classify'

alias l='ls -1'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'


# BS
alias windows="nitch"
