function get_merged_branches --wraps=git\ branch\ --merged\ \|\ grep\ -Ev\ \"\(^\\\*\|t1\|t2\|staging\|production\)\" --wraps=git\ branch\ --merged\ \|\ grep\ -Ev\ \'\(^\\\*\|t1\|t2\|staging\|production\)\' --description alias\ get_merged_branches\ git\ branch\ --merged\ \|\ grep\ -Ev\ \"\(^\\\*\|t1\|t2\|staging\|production\)\"
  git branch --merged | grep -Ev "(^\*|t1|t2|staging|production)" $argv
        
end
