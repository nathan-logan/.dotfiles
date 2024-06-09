function gsdrop --wraps='git stash drop' --description 'alias gsdrop git stash drop'
  git stash drop $argv
        
end
