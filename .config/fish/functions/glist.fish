function glist --wraps='git stash list' --description 'alias glist git stash list'
  git stash list $argv
        
end
