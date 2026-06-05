function cs --wraps='claude --system-prompt="$(serena prompts print-cc-system-prompt-override)"' --description 'alias cs=claude --system-prompt="$(serena prompts print-cc-system-prompt-override)"'
    claude --system-prompt="$(serena prompts print-cc-system-prompt-override)" $argv
end
