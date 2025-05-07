function git_deleted_branches --wraps="git fetch --prune && git branch -vv | grep ': gone]' | awk '{print }'" --description "alias git_deleted_branches git fetch --prune && git branch -vv | grep ': gone]' | awk '{print }'"
  git fetch --prune && git branch -vv | grep ': gone]' | awk '{print }' $argv
        
end
