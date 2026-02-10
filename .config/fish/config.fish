if status is-interactive
    # Commands to run in interactive sessions can go here
end

set --universal nvm_default_version v24.13
set --universal NODE_OPTIONS "--max_old_space_size=4096"

starship init fish | source

set PATH "$PATH":"$HOME/bin/.local/scripts/"

set -Ux NNN_FIFO '/tmp/nnn.fifo'
set -Ux NNN_PLUG 'p:preview-tui;'
set -Ux NNN_OPENER "$HOME/.config/nnn/plugins/nuke"
set -Ux EDITOR "nvim"

set -x OPENAI_API_KEY "$(secret-tool lookup domain openai)"
set -x GEMINI_API_KEY "$(secret-tool lookup domain gemini)"

bind \cf "tmux-sessionizer"

# pnpm
set -gx PNPM_HOME "/home/nathan/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

bind \cb 'gb'

# Added by `rbenv init` on Mon Nov  4 15:14:41 AEST 2024
status --is-interactive; and source (rbenv init -|psub)

fish_ssh_agent

fish_add_path /home/nathan/.spicetify

# opencode
fish_add_path /home/nathan/.opencode/bin
