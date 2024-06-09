function gstashstaged --wraps='git stash push -S' --wraps='git stash push --staged' --wraps='git stash --staged' --wraps='git stash --staged -m' --description 'alias gstashstaged git stash --staged -m'
  git stash --staged -m $argv
        
end
