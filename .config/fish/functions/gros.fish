function gros --wraps='git fetch origin staging && git rebase origin staging' --wraps='git fetch origin staging && git rebase staging' --wraps='git fetch origin staging && gr staging' --wraps='!git fetch origin staging && gr origin/staging' --wraps='git fetch origin staging && gr origin/staging' --description 'alias gros git fetch origin staging && gr origin/staging'
  git fetch origin staging && gr origin/staging $argv
        
end
