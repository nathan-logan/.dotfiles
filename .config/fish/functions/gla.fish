function gla --wraps='git log --oneline --graph --decorate --all -30' --description 'alias gla=git log --oneline --graph --decorate --all -30'
    git log --oneline --graph --decorate --all -30 $argv
end
