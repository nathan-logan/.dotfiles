function grabort --wraps='git rebase --abort' --description 'alias grabort git rebase --abort'
  git rebase --abort $argv
        
end
