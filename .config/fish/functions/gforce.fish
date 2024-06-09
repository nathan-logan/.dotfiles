function gforce --wraps='git push --force-with-lease' --description 'alias gforce git push --force-with-lease'
  git push --force-with-lease $argv
        
end
