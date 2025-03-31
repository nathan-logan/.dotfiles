if status is-interactive
    # Commands to run in interactive sessions can go here
end

set --universal nvm_default_version v22.14
set --universal NODE_OPTIONS "--max_old_space_size=4096"

starship init fish | source

set PATH "$PATH":"$HOME/bin/.local/scripts/"

bind \cf "tmux-sessionizer"

# pnpm
set -gx PNPM_HOME "/home/nathan/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

bind \cb 'gb'

# Added by `rbenv init` on Mon Nov  4 15:14:41 AEST 2024
status --is-interactive; and ~/.rbenv/bin/rbenv init - --no-rehash fish | source

fish_ssh_agent
