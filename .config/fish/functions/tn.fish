function tn --wraps='tmux new-session -s $argv -n $argv' --description 'alias tn tmux new-session -s $argv -n $argv'
  tmux new-session -s $argv -n $argv
        
end
