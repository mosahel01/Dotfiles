function prunsc --wraps='sudo pacman -Runsc ' --description 'alias prunsc sudo pacman -Runsc '
  sudo pacman -Runsc  $argv
        
end
