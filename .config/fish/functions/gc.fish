function gc
    if test (count $argv) -eq 0
        echo "Usage: gc <branch_type> <commit_message...>"
        echo "Error: Missing branch type and commit message."
        return 1
    end

    # get the ticket number using the current branch name, e.g PKB-5366
    set ticket (git rev-parse --abbrev-ref HEAD | string match -r "(?:PKB)-[^-]*")

    set branch_type $argv[1]

    if test (count $argv) -lt 2
        echo "Usage: gc <branch_type> <commit_message...>"
        echo "Error: Missing commit message."
        return 1
    end

    set commit_message (string join " " $argv[2..])

    if test -n "$ticket"
        if test $status -eq 0 
            set full_commit_message "$branch_type($ticket): $commit_message"
        else
            # Fallback if ticket pattern didn't match
            echo "Warning: Could not extract ticket number from branch. Committing without ticket prefix."
            set full_commit_message "$branch_type: $commit_message"
        end
    else
        set full_commit_message "$branch_type: $commit_message"
    end

    echo "Running: git commit -m \"$full_commit_message\"" 
    git commit -m "$full_commit_message" -e

    if test $status -ne 0
        echo "Error: git commit failed."
        return $status
    end

    return 0
end
