if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias config='/usr/bin/git --git-dir=/home/nathan/.cfg/ --work-tree=/home/nathan'

starship init fish | source
