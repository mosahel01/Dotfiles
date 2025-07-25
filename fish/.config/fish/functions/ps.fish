function ps --wraps='sudo pacman -S' --description 'alias ps sudo pacman -S'
  sudo pacman -S $argv
        
end
