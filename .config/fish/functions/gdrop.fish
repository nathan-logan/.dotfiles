function gdrop --wraps='git drop' --wraps='git stash drop' --description 'alias gdrop git stash drop'
  git stash drop $argv
        
end
