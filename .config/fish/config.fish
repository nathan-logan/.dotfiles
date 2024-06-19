if status is-interactive
    # Commands to run in interactive sessions can go here
end

set --universal nvm_default_version v20.14.0

starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/nathan/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

bind \cb 'gb'
