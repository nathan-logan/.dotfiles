function gstash --wraps='git stash push --include-untracked -m' --description 'alias gstash git stash push --include-untracked -m'
  git stash push --include-untracked -m $argv
        
end
