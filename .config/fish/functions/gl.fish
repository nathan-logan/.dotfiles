function gl --wraps='git log --oneline --graph --decorate -20' --description 'alias gl=git log --oneline --graph --decorate -20'
    git log --oneline --graph --decorate -20 $argv
end
