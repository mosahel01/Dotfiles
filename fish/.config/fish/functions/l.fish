function l --wraps='eza -l --icons -tree' --wraps='eza -l --icons --tree' --wraps='eza --icons --tree' --wraps='eza -a --icons --tree' --wraps='eza -al --icons --tree level=1' --wraps='eza -al --icons --tree level=2' --wraps='eza -al --icons --tree --level=2' --wraps='eza -al --icons --tree --level=1' --description 'alias l eza -al --icons --tree --level=2'
  eza -al --icons --tree --level=2 $argv
        
end
