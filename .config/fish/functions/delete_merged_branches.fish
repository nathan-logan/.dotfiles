function delete_merged_branches --wraps='get_merged_branches | xargs git branch -d' --description 'alias delete_merged_branches=get_merged_branches | xargs git branch -d'
  get_merged_branches | xargs git branch -d $argv
        
end
