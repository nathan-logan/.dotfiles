function costaging --wraps='gco staging && gp' --wraps='gco staging && gpull' --description 'alias costaging gco staging && gpull'
  gco staging && gpull $argv
        
end
