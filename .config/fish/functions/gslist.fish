function gslist --wraps='git stash list' --description 'alias gslist git stash list'
  git stash list $argv
        
end
