function gundo --wraps='git reset --soft HEAD~1' --description 'alias gundo=git reset --soft HEAD~1'
    git reset --soft HEAD~1 $argv
end
