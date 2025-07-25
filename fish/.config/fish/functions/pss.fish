function pss --wraps='sudo pacman -Ss' --wraps='pacman -Ss' --description 'alias pss pacman -Ss'
  pacman -Ss $argv
        
end
